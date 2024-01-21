#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QVariant>
#include <QVector>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString word_left READ wordL NOTIFY wordUpdated FINAL)
    Q_PROPERTY(QString word_middle READ wordM NOTIFY wordUpdated FINAL)
    Q_PROPERTY(QString word_right READ wordR NOTIFY wordUpdated FINAL)
    Q_PROPERTY(int automaton_pos READ automatonPos NOTIFY automatonPosUpdated FINAL)
    Q_PROPERTY(int end_word_pos READ endWordPos NOTIFY automatonPosUpdated FINAL)
    Q_PROPERTY(QChar next_letter READ nextLetter NOTIFY automatonPosUpdated FINAL)

public:

    explicit Backend(QObject *parent = nullptr);

private:
    // in case of m_word is 'some word'(size=9 then word range is [0, 8]), then range of m_letter_pos is [-1, 9]
    // where -1 is start pos (no letter is currently selected),
    // where 9 is end pos (no letter is selected) and is seen as finish value which returns red or green color of circle
    // [' ', 's', 'o', 'm', 'e', ' ', 'w', 'o', 'r', 'd', ' ']
    //     [ 's', 'o', 'm', 'e', ' ', 'w', 'o', 'r', 'd']
    bool isBegin() const;
    bool isWordBegin() const;
    bool isWord() const;
    bool isWordEnd() const;
    bool isEnd() const;

public:
    QString wordL() const;
    QString wordM() const;
    QString wordR() const;

    int automatonPos() const;
    int endWordPos() const;
    QChar nextLetter() const;

signals:
    void wordUpdated();

    void automatonPosUpdated();

public slots:
    void setWord(QVariant word);

    void incrementIndex();
    void decrementIndex();

    void goBackAction();

private:
    QString m_word;

    int m_letter_pos; // range [-1, m_word.size()] // -1 begin pos before m_word string, m_word.size() end pos after m_word string
    static constexpr int s_letter_begin_pos = -1;

    int m_automaton_pos; // range [-1, 0, 1, ..., *circle count*]   // -1 begin pos in automaton
    static constexpr int s_begin_automaton_pos = -1;

    QVector<int> m_automaton_prev_step;

    int m_end_word_pos; // range [-1, 0, 1, ..., *circle count*]  // -1 is not the end yet
    static constexpr int s_not_end_pos = -1;

    QChar m_next_letter; // next letter that will be active if you press right button
};

#endif // BACKEND_H
