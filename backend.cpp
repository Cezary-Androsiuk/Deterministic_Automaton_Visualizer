#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject{parent}
{
    this->m_letter_pos = Backend::s_letter_begin_pos;
    this->m_automaton_pos = Backend::s_begin_automaton_pos;
    this->m_end_word_pos = Backend::s_not_end_pos;
    this->m_next_letter = QChar(0);
}

bool Backend::isBegin() const
{
    return this->m_letter_pos == Backend::s_letter_begin_pos;
}
bool Backend::isWordBegin() const
{
    return this->m_letter_pos == 0;
}
bool Backend::isWord() const
{
    return 0 <= this->m_letter_pos && this->m_letter_pos < this->m_word.size();
}
bool Backend::isWordEnd() const
{
    return this->m_letter_pos == this->m_word.size() -1;
}
bool Backend::isEnd() const
{
    return this->m_letter_pos == this->m_word.size();
}

QString Backend::wordL() const
{
    if(this->m_letter_pos < 0)
        return QString("");
    else if(this->m_letter_pos >= this->m_word.size())
        return QString(this->m_word);

    QString word_left(this->m_word);
    const int rm_size = word_left.size() - this->m_letter_pos;
    return word_left.remove(this->m_letter_pos, rm_size);;
}

QString Backend::wordM() const
{
    if(this->m_letter_pos < 0)
        return QString("  ");
    else if(this->m_letter_pos >= this->m_word.size())
        return QString("  ");

    return this->m_word.at(this->m_letter_pos);
}

QString Backend::wordR() const
{
    if(this->m_letter_pos < 0)
        return QString(this->m_word);
    else if(this->m_letter_pos >= this->m_word.size())
        return QString("");

    QString word_right(this->m_word);
    const int rm_size = word_right.size() - (word_right.size() - this->m_letter_pos-1);
    return word_right.remove(0, rm_size);
}

int Backend::automatonPos() const
{
    return this->m_automaton_pos;
}

int Backend::endWordPos() const
{
    return this->m_end_word_pos;
}

QChar Backend::nextLetter() const
{
    return this->m_next_letter;
}

void Backend::setWord(QVariant word)
{
    this->m_word = word.toString();
    emit this->wordUpdated();
}

void Backend::incrementIndex()
{

    if(!this->isEnd())
        this->m_letter_pos ++;

    this->m_automaton_prev_step.append(this->m_automaton_pos);

    this->m_end_word_pos = Backend::s_not_end_pos;
    this->m_next_letter = QChar(0);

    if(this->isWordBegin())
    {
        this->m_automaton_pos = 0;
        if(!this->isWordEnd())
            this->m_next_letter = this->m_word.at(this->m_letter_pos+1);
    }
    else if(this->isEnd())
    {
        this->m_end_word_pos = this->m_automaton_pos;
    }
    else if(this->isWord())
    {
        QChar letter(this->m_word.at(this->m_letter_pos));

        switch(this->m_automaton_pos){
        case 0:
            if (letter == 'a') this->m_automaton_pos = 0;
            if (letter == 'b') this->m_automaton_pos = 1;
            break;
        case 1:
            if (letter == 'a') this->m_automaton_pos = 0;
            if (letter == 'b') this->m_automaton_pos = 2;
            break;
        case 2:
            if (letter == 'a') this->m_automaton_pos = 3;
            if (letter == 'b') this->m_automaton_pos = 2;
            break;
        case 3:
            if (letter == 'a') this->m_automaton_pos = 4;
            if (letter == 'b') this->m_automaton_pos = 1;
            break;
        case 4:
            if (letter == 'a') this->m_automaton_pos = 0;
            if (letter == 'b') this->m_automaton_pos = 1;
            break;
        }
        if(!this->isWordEnd())
            this->m_next_letter = this->m_word.at(this->m_letter_pos+1);
    }

    emit this->wordUpdated();
    emit this->automatonPosUpdated();
}

void Backend::decrementIndex()
{
    if(!this->isBegin())
        this->m_letter_pos --;

    this->m_end_word_pos = Backend::s_not_end_pos;
    this->m_next_letter = QChar(0);

    if(!this->isBegin())
    {
        this->m_automaton_pos = this->m_automaton_prev_step.last();
        this->m_automaton_prev_step.removeLast();
        if(!this->isWordEnd())
            this->m_next_letter = this->m_word.at(this->m_letter_pos+1);
    }
    else
    {
        this->m_automaton_pos = Backend::s_begin_automaton_pos;
    }

    emit this->wordUpdated();
    emit this->automatonPosUpdated();
}

void Backend::goBackAction()
{
    this->m_word.clear();
    this->m_letter_pos = Backend::s_letter_begin_pos;

    this->m_automaton_pos = Backend::s_begin_automaton_pos;
    this->m_automaton_prev_step.clear();

    this->m_end_word_pos = Backend::s_not_end_pos;

    this->m_next_letter = QChar(0);

    emit this->automatonPosUpdated();
}



















