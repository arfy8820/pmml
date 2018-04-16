/* ANSI-C code produced by gperf version 3.1 */
/* Command-line: gperf -D -p -t -G  */
/* Computed positions: -k'1,3,$' */
#include <stddef.h>

#if !((' ' == 32) && ('!' == 33) && ('"' == 34) && ('#' == 35) \
      && ('%' == 37) && ('&' == 38) && ('\'' == 39) && ('(' == 40) \
      && (')' == 41) && ('*' == 42) && ('+' == 43) && (',' == 44) \
      && ('-' == 45) && ('.' == 46) && ('/' == 47) && ('0' == 48) \
      && ('1' == 49) && ('2' == 50) && ('3' == 51) && ('4' == 52) \
      && ('5' == 53) && ('6' == 54) && ('7' == 55) && ('8' == 56) \
      && ('9' == 57) && (':' == 58) && (';' == 59) && ('<' == 60) \
      && ('=' == 61) && ('>' == 62) && ('?' == 63) && ('A' == 65) \
      && ('B' == 66) && ('C' == 67) && ('D' == 68) && ('E' == 69) \
      && ('F' == 70) && ('G' == 71) && ('H' == 72) && ('I' == 73) \
      && ('J' == 74) && ('K' == 75) && ('L' == 76) && ('M' == 77) \
      && ('N' == 78) && ('O' == 79) && ('P' == 80) && ('Q' == 81) \
      && ('R' == 82) && ('S' == 83) && ('T' == 84) && ('U' == 85) \
      && ('V' == 86) && ('W' == 87) && ('X' == 88) && ('Y' == 89) \
      && ('Z' == 90) && ('[' == 91) && ('\\' == 92) && (']' == 93) \
      && ('^' == 94) && ('_' == 95) && ('a' == 97) && ('b' == 98) \
      && ('c' == 99) && ('d' == 100) && ('e' == 101) && ('f' == 102) \
      && ('g' == 103) && ('h' == 104) && ('i' == 105) && ('j' == 106) \
      && ('k' == 107) && ('l' == 108) && ('m' == 109) && ('n' == 110) \
      && ('o' == 111) && ('p' == 112) && ('q' == 113) && ('r' == 114) \
      && ('s' == 115) && ('t' == 116) && ('u' == 117) && ('v' == 118) \
      && ('w' == 119) && ('x' == 120) && ('y' == 121) && ('z' == 122) \
      && ('{' == 123) && ('|' == 124) && ('}' == 125) && ('~' == 126))
/* The character set is not based on ISO-646.  */
#error "gperf generated tables don't work with this execution character set. Please report a bug to <bug-gperf@gnu.org>."
#endif


#include "keyword.h"
struct keyword { char *name;  int  val; };

#define TOTAL_KEYWORDS 94
#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 15
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 187
/* maximum key range = 187, duplicates = 0 */

#ifdef __GNUC__
__inline
#else
#ifdef __cplusplus
inline
#endif
#endif
static unsigned int
hash (register const char *str, register size_t len)
{
  static unsigned char asso_values[] =
    {
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
        0, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188,  20,  30,  50,
       15,  40,  20,  45,  95,  70,   0,  80,  15,   5,
       90,  35, 100,   0,  20,   0,   0,  10,  40,  25,
        5,   0, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188, 188, 188, 188, 188,
      188, 188, 188, 188, 188, 188
    };
  register unsigned int hval = len;

  switch (hval)
    {
      default:
        hval += asso_values[(unsigned char)str[2]];
      /*FALLTHROUGH*/
      case 2:
      case 1:
        hval += asso_values[(unsigned char)str[0]];
        break;
    }
  return hval + asso_values[(unsigned char)str[len - 1]];
}

struct keyword wordlist[] =
  {
    {"t", T_T},
    {"text", T_TEXT},
    {"set_eff_chs", T_SET_EFF_CHS},
    {"set_thru_chs", T_SET_THRU_CHS},
    {"set_eff_etypes", T_SET_EFF_ETYPES},
    {"set_thru_etypes", T_SET_THRU_ETYPES},
    {"dt", T_DT},
    {"rt", T_RT},
    {"alt", T_ALT},
    {"reject", T_REJECT},
    {"du", T_DU},
    {"meta", T_META},
    {"l", T_L},
    {"tb", T_TB},
    {"shl", T_SHL},
    {"dr", T_DR},
    {"seqno", T_SEQNO},
    {"del_eff_chs", T_DEL_EFF_CHS},
    {"default", T_DEFAULT},
    {"shr", T_SHR},
    {"del_eff_etypes", T_DEL_EFF_ETYPES},
    {"tempo", T_TEMPO},
    {"add_eff_chs", T_ADD_EFF_CHS},
    {"gt", T_DU
},
    {"xor", T_XOR},
    {"add_eff_etypes", T_ADD_EFF_ETYPES},
    {"undef", T_UNDEF},
    {"do", T_DO},
    {"all", T_ALL},
    {"load", T_LOAD},
    {"arbit", T_ARBIT},
    {"timesig", T_TIMESIG},
    {"def", T_DEF},
    {"defthread", T_DEFTHREAD},
    {"defeff", T_DEFEFF},
    {"disable", T_DISABLE},
    {"for", T_FOR},
    {"elsif", T_ELSIF},
    {"signal", T_SIGNAL},
    {"gr", T_DR
},
    {"o", T_O},
    {"ac", T_AC},
    {"end", T_END},
    {"shift", T_SHIFT},
    {"insert", T_INSERT},
    {"ctrl_pt", T_CTRL_PT},
    {"ctrl_any", T_CTRL_ANY},
    {"eval", T_EVAL},
    {"v", T_V},
    {"tk", T_TK},
    {"key", T_KEY},
    {"else", T_ELSE},
    {"local", T_LOCAL},
    {"evalstr", T_EVALSTR},
    {"ctrl", T_CTRL},
    {"if", T_IF},
    {"cpr", T_CPR},
    {"case", T_CASE},
    {"excl2", T_EXCL2},
    {"sh", T_SH},
    {"wait", T_WAIT},
    {"tp", T_TP},
    {"edef", T_EDEF},
    {"enable", T_ENABLE},
    {"excl", T_EXCL},
    {"ctrl_to", T_CTRL_TO},
    {"ctrl_cto", T_CTRL_CTO},
    {"detach", T_DETACH},
    {"dp", T_DP},
    {"note_off", T_NOTE_OFF},
    {"ecode", T_ECODE},
    {"attach", T_ATTACH},
    {"loadtrk", T_LOADTRK},
    {"null", T_NULL},
    {"repeat", T_REPEAT},
    {"close", T_CLOSE},
    {"keysig", T_KEYSIG},
    {"nv", T_NV},
    {"note", T_NOTE},
    {"bend", T_BEND},
    {"while", T_WHILE},
    {"append", T_APPEND},
    {"foreach", T_FOREACH},
    {"init", T_INIT},
    {"smpte", T_SMPTE},
    {"ch", T_CH},
    {"wrap", T_WRAP},
    {"break", T_BREAK},
    {"include", T_INCLUDE},
    {"switch", T_SWITCH},
    {"n", T_N},
    {"kp", T_KP},
    {"prog", T_PROG},
    {"note_on", T_NOTE_ON}
  };

static signed char lookup[] =
  {
    -1,  0, -1, -1, -1, -1, -1, -1, -1,  1, -1,  2,  3, -1,
     4,  5, -1,  6, -1, -1, -1, -1,  7,  8, -1, -1,  9, 10,
    -1, 11, -1, 12, 13, 14, -1, -1, -1, 15, -1, -1, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, -1, 27, 28, 29, 30,
    -1, 31, 32, 33, -1, 34, 35, 36, -1, 37, 38, 39, -1, -1,
    -1, 40, 41, 42, -1, 43, 44, 45, 46, 47, -1, 48, 49, 50,
    51, 52, -1, 53, -1, 54, -1, -1, 55, 56, 57, 58, -1, 59,
    -1, 60, -1, -1, 61, -1, 62, -1, 63, -1, -1, 64, -1, -1,
    65, 66, -1, -1, 67, 68, 69, -1, 70, 71, 72, -1, 73, -1,
    74, -1, -1, -1, 75, 76, 77, -1, 78, -1, -1, -1, -1, 79,
    80, 81, 82, -1, 83, 84, -1, 85, -1, 86, -1, -1, -1, -1,
    -1, 87, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 88,
    -1, -1, -1, 89, -1, -1, -1, -1, -1, -1, -1, -1, -1, 90,
    91, -1, 92, -1, -1, 93
  };

struct keyword *
in_word_set (register const char *str, register size_t len)
{
  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register unsigned int key = hash (str, len);

      if (key <= MAX_HASH_VALUE)
        {
          register int index = lookup[key];

          if (index >= 0)
            {
              register const char *s = wordlist[index].name;

              if (*str == *s && !strcmp (str + 1, s + 1))
                return &wordlist[index];
            }
        }
    }
  return 0;
}
