Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57697 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932201AbWIEQdS
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:33:18 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.7/8.13.7) with ESMTP id k85GXHlL069800
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 16:33:17 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85GbeHZ2609198
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:37:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85GXGZI005035
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:16 +0200
Received: from localhost (dyn-9-152-216-78.boeblingen.de.ibm.com [9.152.216.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85GXG0E005032
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:16 +0200
Date: Tue, 5 Sep 2006 18:33:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/5] Kconfig: add disable command.
Message-ID: <20060905163316.GC6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 2/5] Kconfig: add disable command.

This patch adds the "disable <name> [if <expr>]" Kconfig command. The
purpose of the command is to allow architectures to disable specific
configuration options. For example "disable GEN_RTC" will disable
the GEN_RTC option, "disable RTC if !EXPERIMENTAL" will disable the
RTC option if the EXPERIMENTAL option is not selected.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 scripts/kconfig/expr.h               |    3 
 scripts/kconfig/menu.c               |    8 
 scripts/kconfig/zconf.gperf          |    1 
 scripts/kconfig/zconf.hash.c_shipped |  121 +++---
 scripts/kconfig/zconf.tab.c_shipped  |  606 ++++++++++++++++++-----------------
 scripts/kconfig/zconf.y              |   22 +
 6 files changed, 409 insertions(+), 352 deletions(-)

diff -urpN linux-2.6/scripts/kconfig/expr.h linux-2.6-patched/scripts/kconfig/expr.h
--- linux-2.6/scripts/kconfig/expr.h	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/expr.h	2006-09-05 16:57:18.000000000 +0200
@@ -78,7 +78,8 @@ struct symbol {
 	tristate visible;
 	int flags;
 	struct property *prop;
-	struct expr *dep, *dep2;
+	struct expr *disable;
+	struct menu *menu;
 	struct expr_value rev_dep;
 };
 
diff -urpN linux-2.6/scripts/kconfig/menu.c linux-2.6-patched/scripts/kconfig/menu.c
--- linux-2.6/scripts/kconfig/menu.c	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/menu.c	2006-09-05 16:57:18.000000000 +0200
@@ -59,6 +59,14 @@ void menu_add_entry(struct symbol *sym)
 
 void menu_end_entry(void)
 {
+	struct expr *dep;
+	if (!current_entry->sym)
+		return;
+	current_entry->sym->menu = current_entry;
+	if (!current_entry->sym->disable)
+		return;
+	dep = expr_alloc_one(E_NOT, current_entry->sym->disable);
+	current_entry->dep = expr_alloc_and(current_entry->dep, dep);
 }
 
 struct menu *menu_add_menu(void)
diff -urpN linux-2.6/scripts/kconfig/zconf.gperf linux-2.6-patched/scripts/kconfig/zconf.gperf
--- linux-2.6/scripts/kconfig/zconf.gperf	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/zconf.gperf	2006-09-05 16:57:18.000000000 +0200
@@ -43,4 +43,5 @@ option,		T_OPTION,	TF_COMMAND
 on,		T_ON,		TF_PARAM
 modules,	T_OPT_MODULES,	TF_OPTION
 defconfig_list,	T_OPT_DEFCONFIG_LIST,TF_OPTION
+disable,	T_DISABLE,	TF_COMMAND
 %%
diff -urpN linux-2.6/scripts/kconfig/zconf.hash.c_shipped linux-2.6-patched/scripts/kconfig/zconf.hash.c_shipped
--- linux-2.6/scripts/kconfig/zconf.hash.c_shipped	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/zconf.hash.c_shipped	2006-09-05 16:57:18.000000000 +0200
@@ -30,7 +30,7 @@
 #endif
 
 struct kconf_id;
-/* maximum key range = 45, duplicates = 0 */
+/* maximum key range = 50, duplicates = 0 */
 
 #ifdef __GNUC__
 __inline
@@ -44,32 +44,32 @@ kconf_id_hash (register const char *str,
 {
   static unsigned char asso_values[] =
     {
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 25, 30, 15,
-       0, 15,  0, 47,  5, 15, 47, 47, 30, 20,
-       5,  0, 25, 15,  0,  0, 10, 35, 47, 47,
-       5, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47, 47, 47, 47, 47,
-      47, 47, 47, 47, 47, 47
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 30, 40, 15,
+       0, 15,  0, 52,  5, 15, 52, 52, 10, 20,
+       5,  0, 30, 15,  0, 25, 10, 15, 52, 52,
+       5, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
+      52, 52, 52, 52, 52, 52
     };
   register int hval = len;
 
@@ -89,7 +89,6 @@ kconf_id_hash (register const char *str,
 struct kconf_id_strings_t
   {
     char kconf_id_strings_str2[sizeof("on")];
-    char kconf_id_strings_str6[sizeof("string")];
     char kconf_id_strings_str7[sizeof("default")];
     char kconf_id_strings_str8[sizeof("def_bool")];
     char kconf_id_strings_str10[sizeof("range")];
@@ -100,6 +99,7 @@ struct kconf_id_strings_t
     char kconf_id_strings_str16[sizeof("option")];
     char kconf_id_strings_str17[sizeof("if")];
     char kconf_id_strings_str18[sizeof("optional")];
+    char kconf_id_strings_str19[sizeof("help")];
     char kconf_id_strings_str20[sizeof("endif")];
     char kconf_id_strings_str21[sizeof("choice")];
     char kconf_id_strings_str22[sizeof("endmenu")];
@@ -109,23 +109,23 @@ struct kconf_id_strings_t
     char kconf_id_strings_str27[sizeof("modules")];
     char kconf_id_strings_str28[sizeof("int")];
     char kconf_id_strings_str29[sizeof("menu")];
-    char kconf_id_strings_str31[sizeof("prompt")];
-    char kconf_id_strings_str32[sizeof("depends")];
+    char kconf_id_strings_str31[sizeof("string")];
+    char kconf_id_strings_str32[sizeof("disable")];
     char kconf_id_strings_str33[sizeof("tristate")];
-    char kconf_id_strings_str34[sizeof("bool")];
     char kconf_id_strings_str35[sizeof("menuconfig")];
-    char kconf_id_strings_str36[sizeof("select")];
-    char kconf_id_strings_str37[sizeof("boolean")];
-    char kconf_id_strings_str39[sizeof("help")];
-    char kconf_id_strings_str41[sizeof("source")];
+    char kconf_id_strings_str36[sizeof("prompt")];
+    char kconf_id_strings_str37[sizeof("depends")];
+    char kconf_id_strings_str41[sizeof("select")];
     char kconf_id_strings_str42[sizeof("comment")];
     char kconf_id_strings_str43[sizeof("mainmenu")];
-    char kconf_id_strings_str46[sizeof("enable")];
+    char kconf_id_strings_str44[sizeof("bool")];
+    char kconf_id_strings_str46[sizeof("source")];
+    char kconf_id_strings_str47[sizeof("boolean")];
+    char kconf_id_strings_str51[sizeof("enable")];
   };
 static struct kconf_id_strings_t kconf_id_strings_contents =
   {
     "on",
-    "string",
     "default",
     "def_bool",
     "range",
@@ -136,6 +136,7 @@ static struct kconf_id_strings_t kconf_i
     "option",
     "if",
     "optional",
+    "help",
     "endif",
     "choice",
     "endmenu",
@@ -145,17 +146,18 @@ static struct kconf_id_strings_t kconf_i
     "modules",
     "int",
     "menu",
-    "prompt",
-    "depends",
+    "string",
+    "disable",
     "tristate",
-    "bool",
     "menuconfig",
+    "prompt",
+    "depends",
     "select",
-    "boolean",
-    "help",
-    "source",
     "comment",
     "mainmenu",
+    "bool",
+    "source",
+    "boolean",
     "enable"
   };
 #define kconf_id_strings ((const char *) &kconf_id_strings_contents)
@@ -167,19 +169,18 @@ kconf_id_lookup (register const char *st
 {
   enum
     {
-      TOTAL_KEYWORDS = 33,
+      TOTAL_KEYWORDS = 34,
       MIN_WORD_LENGTH = 2,
       MAX_WORD_LENGTH = 14,
       MIN_HASH_VALUE = 2,
-      MAX_HASH_VALUE = 46
+      MAX_HASH_VALUE = 51
     };
 
   static struct kconf_id wordlist[] =
     {
       {-1}, {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str2,		T_ON,		TF_PARAM},
-      {-1}, {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str6,		T_TYPE,		TF_COMMAND, S_STRING},
+      {-1}, {-1}, {-1}, {-1},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str7,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
       {-1},
@@ -192,7 +193,7 @@ kconf_id_lookup (register const char *st
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str16,		T_OPTION,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,		T_IF,		TF_COMMAND|TF_PARAM},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str18,	T_OPTIONAL,	TF_COMMAND},
-      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str19,		T_HELP,		TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str20,		T_ENDIF,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_CHOICE,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,	T_ENDMENU,	TF_COMMAND},
@@ -204,21 +205,23 @@ kconf_id_lookup (register const char *st
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str28,		T_TYPE,		TF_COMMAND, S_INT},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str29,		T_MENU,		TF_COMMAND},
       {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_PROMPT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_DEPENDS,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_TYPE,		TF_COMMAND, S_STRING},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_DISABLE,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str33,	T_TYPE,		TF_COMMAND, S_TRISTATE},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str34,		T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str35,	T_MENUCONFIG,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str36,		T_SELECT,	TF_COMMAND},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str37,	T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str39,		T_HELP,		TF_COMMAND},
       {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_SOURCE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str35,	T_MENUCONFIG,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str36,		T_PROMPT,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str37,	T_DEPENDS,	TF_COMMAND},
+      {-1}, {-1}, {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_SELECT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str42,	T_COMMENT,	TF_COMMAND},
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str43,	T_MAINMENU,	TF_COMMAND},
-      {-1}, {-1},
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str46,		T_SELECT,	TF_COMMAND}
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str44,		T_TYPE,		TF_COMMAND, S_BOOLEAN},
+      {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str46,		T_SOURCE,	TF_COMMAND},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str47,	T_TYPE,		TF_COMMAND, S_BOOLEAN},
+      {-1}, {-1}, {-1},
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str51,		T_SELECT,	TF_COMMAND}
     };
 
   if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
diff -urpN linux-2.6/scripts/kconfig/zconf.tab.c_shipped linux-2.6-patched/scripts/kconfig/zconf.tab.c_shipped
--- linux-2.6/scripts/kconfig/zconf.tab.c_shipped	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/zconf.tab.c_shipped	2006-09-05 16:57:18.000000000 +0200
@@ -87,16 +87,17 @@
      T_RANGE = 278,
      T_OPTION = 279,
      T_ON = 280,
-     T_WORD = 281,
-     T_WORD_QUOTE = 282,
-     T_UNEQUAL = 283,
-     T_CLOSE_PAREN = 284,
-     T_OPEN_PAREN = 285,
-     T_EOL = 286,
-     T_OR = 287,
-     T_AND = 288,
-     T_EQUAL = 289,
-     T_NOT = 290
+     T_DISABLE = 281,
+     T_WORD = 282,
+     T_WORD_QUOTE = 283,
+     T_UNEQUAL = 284,
+     T_CLOSE_PAREN = 285,
+     T_OPEN_PAREN = 286,
+     T_EOL = 287,
+     T_OR = 288,
+     T_AND = 289,
+     T_EQUAL = 290,
+     T_NOT = 291
    };
 #endif
 /* Tokens.  */
@@ -123,16 +124,17 @@
 #define T_RANGE 278
 #define T_OPTION 279
 #define T_ON 280
-#define T_WORD 281
-#define T_WORD_QUOTE 282
-#define T_UNEQUAL 283
-#define T_CLOSE_PAREN 284
-#define T_OPEN_PAREN 285
-#define T_EOL 286
-#define T_OR 287
-#define T_AND 288
-#define T_EQUAL 289
-#define T_NOT 290
+#define T_DISABLE 281
+#define T_WORD 282
+#define T_WORD_QUOTE 283
+#define T_UNEQUAL 284
+#define T_CLOSE_PAREN 285
+#define T_OPEN_PAREN 286
+#define T_EOL 287
+#define T_OR 288
+#define T_AND 289
+#define T_EQUAL 290
+#define T_NOT 291
 
 
 
@@ -372,20 +374,20 @@ union yyalloc
 /* YYFINAL -- State number of the termination state. */
 #define YYFINAL  3
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   275
+#define YYLAST   280
 
 /* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  36
+#define YYNTOKENS  37
 /* YYNNTS -- Number of nonterminals. */
-#define YYNNTS  45
+#define YYNNTS  46
 /* YYNRULES -- Number of rules. */
-#define YYNRULES  110
+#define YYNRULES  112
 /* YYNRULES -- Number of states. */
-#define YYNSTATES  183
+#define YYNSTATES  188
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   290
+#define YYMAXUTOK   291
 
 #define YYTRANSLATE(YYX)						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
@@ -422,7 +424,7 @@ static const unsigned char yytranslate[]
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
       25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35
+      35,    36
 };
 
 #if YYDEBUG
@@ -432,71 +434,72 @@ static const unsigned short int yyprhs[]
 {
        0,     0,     3,     5,     6,     9,    12,    15,    20,    23,
       28,    33,    37,    39,    41,    43,    45,    47,    49,    51,
-      53,    55,    57,    59,    61,    63,    67,    70,    74,    77,
-      81,    84,    85,    88,    91,    94,    97,   100,   103,   107,
-     112,   117,   122,   128,   132,   133,   137,   138,   141,   144,
-     147,   149,   153,   154,   157,   160,   163,   166,   169,   174,
-     178,   181,   186,   187,   190,   194,   196,   200,   201,   204,
-     207,   210,   214,   217,   219,   223,   224,   227,   230,   233,
-     237,   241,   244,   247,   250,   251,   254,   257,   260,   265,
-     269,   273,   274,   277,   279,   281,   284,   287,   290,   292,
-     295,   296,   299,   301,   305,   309,   313,   316,   320,   324,
-     326
+      53,    55,    57,    59,    61,    63,    65,    69,    72,    76,
+      79,    83,    86,    87,    90,    93,    96,    99,   102,   105,
+     109,   114,   119,   124,   130,   134,   135,   139,   140,   143,
+     146,   149,   151,   155,   156,   159,   162,   165,   168,   171,
+     176,   180,   183,   188,   189,   192,   196,   198,   202,   203,
+     206,   209,   212,   216,   219,   221,   225,   226,   229,   232,
+     235,   239,   243,   246,   249,   252,   253,   256,   259,   262,
+     267,   271,   275,   276,   279,   281,   283,   286,   289,   292,
+     294,   297,   298,   301,   303,   307,   311,   315,   318,   322,
+     326,   328,   330
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS. */
 static const yysigned_char yyrhs[] =
 {
-      37,     0,    -1,    38,    -1,    -1,    38,    40,    -1,    38,
-      54,    -1,    38,    65,    -1,    38,     3,    75,    77,    -1,
-      38,    76,    -1,    38,    26,     1,    31,    -1,    38,    39,
-       1,    31,    -1,    38,     1,    31,    -1,    16,    -1,    19,
+      38,     0,    -1,    39,    -1,    -1,    39,    41,    -1,    39,
+      55,    -1,    39,    66,    -1,    39,     3,    76,    78,    -1,
+      39,    77,    -1,    39,    27,     1,    32,    -1,    39,    40,
+       1,    32,    -1,    39,     1,    32,    -1,    16,    -1,    19,
       -1,    20,    -1,    22,    -1,    18,    -1,    23,    -1,    21,
-      -1,    31,    -1,    60,    -1,    69,    -1,    43,    -1,    45,
-      -1,    67,    -1,    26,     1,    31,    -1,     1,    31,    -1,
-      10,    26,    31,    -1,    42,    46,    -1,    11,    26,    31,
-      -1,    44,    46,    -1,    -1,    46,    47,    -1,    46,    48,
-      -1,    46,    73,    -1,    46,    71,    -1,    46,    41,    -1,
-      46,    31,    -1,    20,    74,    31,    -1,    19,    75,    78,
-      31,    -1,    21,    79,    78,    31,    -1,    22,    26,    78,
-      31,    -1,    23,    80,    80,    78,    31,    -1,    24,    49,
-      31,    -1,    -1,    49,    26,    50,    -1,    -1,    34,    75,
-      -1,     7,    31,    -1,    51,    55,    -1,    76,    -1,    52,
-      57,    53,    -1,    -1,    55,    56,    -1,    55,    73,    -1,
-      55,    71,    -1,    55,    31,    -1,    55,    41,    -1,    19,
-      75,    78,    31,    -1,    20,    74,    31,    -1,    18,    31,
-      -1,    21,    26,    78,    31,    -1,    -1,    57,    40,    -1,
-      14,    79,    77,    -1,    76,    -1,    58,    61,    59,    -1,
-      -1,    61,    40,    -1,    61,    65,    -1,    61,    54,    -1,
-       4,    75,    31,    -1,    62,    72,    -1,    76,    -1,    63,
-      66,    64,    -1,    -1,    66,    40,    -1,    66,    65,    -1,
-      66,    54,    -1,     6,    75,    31,    -1,     9,    75,    31,
-      -1,    68,    72,    -1,    12,    31,    -1,    70,    13,    -1,
-      -1,    72,    73,    -1,    72,    31,    -1,    72,    41,    -1,
-      16,    25,    79,    31,    -1,    16,    79,    31,    -1,    17,
-      79,    31,    -1,    -1,    75,    78,    -1,    26,    -1,    27,
-      -1,     5,    31,    -1,     8,    31,    -1,    15,    31,    -1,
-      31,    -1,    77,    31,    -1,    -1,    14,    79,    -1,    80,
-      -1,    80,    34,    80,    -1,    80,    28,    80,    -1,    30,
-      79,    29,    -1,    35,    79,    -1,    79,    32,    79,    -1,
-      79,    33,    79,    -1,    26,    -1,    27,    -1
+      -1,    32,    -1,    61,    -1,    70,    -1,    44,    -1,    46,
+      -1,    68,    -1,    82,    -1,    27,     1,    32,    -1,     1,
+      32,    -1,    10,    27,    32,    -1,    43,    47,    -1,    11,
+      27,    32,    -1,    45,    47,    -1,    -1,    47,    48,    -1,
+      47,    49,    -1,    47,    74,    -1,    47,    72,    -1,    47,
+      42,    -1,    47,    32,    -1,    20,    75,    32,    -1,    19,
+      76,    79,    32,    -1,    21,    80,    79,    32,    -1,    22,
+      27,    79,    32,    -1,    23,    81,    81,    79,    32,    -1,
+      24,    50,    32,    -1,    -1,    50,    27,    51,    -1,    -1,
+      35,    76,    -1,     7,    32,    -1,    52,    56,    -1,    77,
+      -1,    53,    58,    54,    -1,    -1,    56,    57,    -1,    56,
+      74,    -1,    56,    72,    -1,    56,    32,    -1,    56,    42,
+      -1,    19,    76,    79,    32,    -1,    20,    75,    32,    -1,
+      18,    32,    -1,    21,    27,    79,    32,    -1,    -1,    58,
+      41,    -1,    14,    80,    78,    -1,    77,    -1,    59,    62,
+      60,    -1,    -1,    62,    41,    -1,    62,    66,    -1,    62,
+      55,    -1,     4,    76,    32,    -1,    63,    73,    -1,    77,
+      -1,    64,    67,    65,    -1,    -1,    67,    41,    -1,    67,
+      66,    -1,    67,    55,    -1,     6,    76,    32,    -1,     9,
+      76,    32,    -1,    69,    73,    -1,    12,    32,    -1,    71,
+      13,    -1,    -1,    73,    74,    -1,    73,    32,    -1,    73,
+      42,    -1,    16,    25,    80,    32,    -1,    16,    80,    32,
+      -1,    17,    80,    32,    -1,    -1,    76,    79,    -1,    27,
+      -1,    28,    -1,     5,    32,    -1,     8,    32,    -1,    15,
+      32,    -1,    32,    -1,    78,    32,    -1,    -1,    14,    80,
+      -1,    81,    -1,    81,    35,    81,    -1,    81,    29,    81,
+      -1,    31,    80,    30,    -1,    36,    80,    -1,    80,    33,
+      80,    -1,    80,    34,    80,    -1,    27,    -1,    28,    -1,
+      26,    27,    79,    32,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const unsigned short int yyrline[] =
 {
-       0,   105,   105,   107,   109,   110,   111,   112,   113,   114,
-     115,   119,   123,   123,   123,   123,   123,   123,   123,   127,
-     128,   129,   130,   131,   132,   136,   137,   143,   151,   157,
-     165,   175,   177,   178,   179,   180,   181,   182,   185,   193,
-     199,   209,   215,   221,   224,   226,   237,   238,   243,   252,
-     257,   265,   268,   270,   271,   272,   273,   274,   277,   283,
-     294,   300,   310,   312,   317,   325,   333,   336,   338,   339,
-     340,   345,   352,   357,   365,   368,   370,   371,   372,   375,
-     383,   390,   397,   403,   410,   412,   413,   414,   417,   422,
-     427,   435,   437,   442,   443,   446,   447,   448,   452,   453,
-     456,   457,   460,   461,   462,   463,   464,   465,   466,   469,
-     470
+       0,   106,   106,   108,   110,   111,   112,   113,   114,   115,
+     116,   120,   124,   124,   124,   124,   124,   124,   124,   128,
+     129,   130,   131,   132,   133,   134,   138,   139,   145,   153,
+     159,   167,   177,   179,   180,   181,   182,   183,   184,   187,
+     195,   201,   211,   217,   223,   226,   228,   239,   240,   245,
+     254,   259,   267,   270,   272,   273,   274,   275,   276,   279,
+     285,   296,   302,   312,   314,   319,   327,   335,   338,   340,
+     341,   342,   347,   354,   359,   367,   370,   372,   373,   374,
+     377,   385,   392,   399,   405,   412,   414,   415,   416,   419,
+     424,   429,   437,   439,   444,   445,   448,   449,   450,   454,
+     455,   458,   459,   462,   463,   464,   465,   466,   467,   468,
+     471,   472,   477
 };
 #endif
 
@@ -509,18 +512,19 @@ static const char *const yytname[] =
   "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
   "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT",
-  "T_SELECT", "T_RANGE", "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE",
-  "T_UNEQUAL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND",
-  "T_EQUAL", "T_NOT", "$accept", "input", "stmt_list", "option_name",
-  "common_stmt", "option_error", "config_entry_start", "config_stmt",
-  "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
-  "config_option", "symbol_option", "symbol_option_list",
-  "symbol_option_arg", "choice", "choice_entry", "choice_end",
-  "choice_stmt", "choice_option_list", "choice_option", "choice_block",
-  "if_entry", "if_end", "if_stmt", "if_block", "menu", "menu_entry",
-  "menu_end", "menu_stmt", "menu_block", "source_stmt", "comment",
-  "comment_stmt", "help_start", "help", "depends_list", "depends",
-  "prompt_stmt_opt", "prompt", "end", "nl", "if_expr", "expr", "symbol", 0
+  "T_SELECT", "T_RANGE", "T_OPTION", "T_ON", "T_DISABLE", "T_WORD",
+  "T_WORD_QUOTE", "T_UNEQUAL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL",
+  "T_OR", "T_AND", "T_EQUAL", "T_NOT", "$accept", "input", "stmt_list",
+  "option_name", "common_stmt", "option_error", "config_entry_start",
+  "config_stmt", "menuconfig_entry_start", "menuconfig_stmt",
+  "config_option_list", "config_option", "symbol_option",
+  "symbol_option_list", "symbol_option_arg", "choice", "choice_entry",
+  "choice_end", "choice_stmt", "choice_option_list", "choice_option",
+  "choice_block", "if_entry", "if_end", "if_stmt", "if_block", "menu",
+  "menu_entry", "menu_end", "menu_stmt", "menu_block", "source_stmt",
+  "comment", "comment_stmt", "help_start", "help", "depends_list",
+  "depends", "prompt_stmt_opt", "prompt", "end", "nl", "if_expr", "expr",
+  "symbol", "disable_stmt", 0
 };
 #endif
 
@@ -532,25 +536,25 @@ static const unsigned short int yytoknum
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290
+     285,   286,   287,   288,   289,   290,   291
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const unsigned char yyr1[] =
 {
-       0,    36,    37,    38,    38,    38,    38,    38,    38,    38,
-      38,    38,    39,    39,    39,    39,    39,    39,    39,    40,
-      40,    40,    40,    40,    40,    41,    41,    42,    43,    44,
-      45,    46,    46,    46,    46,    46,    46,    46,    47,    47,
-      47,    47,    47,    48,    49,    49,    50,    50,    51,    52,
-      53,    54,    55,    55,    55,    55,    55,    55,    56,    56,
-      56,    56,    57,    57,    58,    59,    60,    61,    61,    61,
-      61,    62,    63,    64,    65,    66,    66,    66,    66,    67,
-      68,    69,    70,    71,    72,    72,    72,    72,    73,    73,
-      73,    74,    74,    75,    75,    76,    76,    76,    77,    77,
-      78,    78,    79,    79,    79,    79,    79,    79,    79,    80,
-      80
+       0,    37,    38,    39,    39,    39,    39,    39,    39,    39,
+      39,    39,    40,    40,    40,    40,    40,    40,    40,    41,
+      41,    41,    41,    41,    41,    41,    42,    42,    43,    44,
+      45,    46,    47,    47,    47,    47,    47,    47,    47,    48,
+      48,    48,    48,    48,    49,    50,    50,    51,    51,    52,
+      53,    54,    55,    56,    56,    56,    56,    56,    56,    57,
+      57,    57,    57,    58,    58,    59,    60,    61,    62,    62,
+      62,    62,    63,    64,    65,    66,    67,    67,    67,    67,
+      68,    69,    70,    71,    72,    73,    73,    73,    73,    74,
+      74,    74,    75,    75,    76,    76,    77,    77,    77,    78,
+      78,    79,    79,    80,    80,    80,    80,    80,    80,    80,
+      81,    81,    82
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
@@ -558,16 +562,16 @@ static const unsigned char yyr2[] =
 {
        0,     2,     1,     0,     2,     2,     2,     4,     2,     4,
        4,     3,     1,     1,     1,     1,     1,     1,     1,     1,
-       1,     1,     1,     1,     1,     3,     2,     3,     2,     3,
-       2,     0,     2,     2,     2,     2,     2,     2,     3,     4,
-       4,     4,     5,     3,     0,     3,     0,     2,     2,     2,
-       1,     3,     0,     2,     2,     2,     2,     2,     4,     3,
-       2,     4,     0,     2,     3,     1,     3,     0,     2,     2,
-       2,     3,     2,     1,     3,     0,     2,     2,     2,     3,
-       3,     2,     2,     2,     0,     2,     2,     2,     4,     3,
-       3,     0,     2,     1,     1,     2,     2,     2,     1,     2,
-       0,     2,     1,     3,     3,     3,     2,     3,     3,     1,
-       1
+       1,     1,     1,     1,     1,     1,     3,     2,     3,     2,
+       3,     2,     0,     2,     2,     2,     2,     2,     2,     3,
+       4,     4,     4,     5,     3,     0,     3,     0,     2,     2,
+       2,     1,     3,     0,     2,     2,     2,     2,     2,     4,
+       3,     2,     4,     0,     2,     3,     1,     3,     0,     2,
+       2,     2,     3,     2,     1,     3,     0,     2,     2,     2,
+       3,     3,     2,     2,     2,     0,     2,     2,     2,     4,
+       3,     3,     0,     2,     1,     1,     2,     2,     2,     1,
+       2,     0,     2,     1,     3,     3,     3,     2,     3,     3,
+       1,     1,     4
 };
 
 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -577,163 +581,165 @@ static const unsigned char yydefact[] =
 {
        3,     0,     0,     1,     0,     0,     0,     0,     0,     0,
        0,     0,     0,     0,     0,     0,    12,    16,    13,    14,
-      18,    15,    17,     0,    19,     0,     4,    31,    22,    31,
-      23,    52,    62,     5,    67,    20,    84,    75,     6,    24,
-      84,    21,     8,    11,    93,    94,     0,     0,    95,     0,
-      48,    96,     0,     0,     0,   109,   110,     0,     0,     0,
-     102,    97,     0,     0,     0,     0,     0,     0,     0,     0,
-       0,     0,    98,     7,    71,    79,    80,    27,    29,     0,
-     106,     0,     0,    64,     0,     0,     9,    10,     0,     0,
-       0,     0,     0,    91,     0,     0,     0,    44,     0,    37,
-      36,    32,    33,     0,    35,    34,     0,     0,    91,     0,
-      56,    57,    53,    55,    54,    63,    51,    50,    68,    70,
-      66,    69,    65,    86,    87,    85,    76,    78,    74,    77,
-      73,    99,   105,   107,   108,   104,   103,    26,    82,     0,
-       0,     0,   100,     0,   100,   100,   100,     0,     0,     0,
-      83,    60,   100,     0,   100,     0,    89,    90,     0,     0,
-      38,    92,     0,     0,   100,    46,    43,    25,     0,    59,
-       0,    88,   101,    39,    40,    41,     0,     0,    45,    58,
-      61,    42,    47
+      18,    15,    17,     0,     0,    19,     0,     4,    32,    22,
+      32,    23,    53,    63,     5,    68,    20,    85,    76,     6,
+      24,    85,    21,     8,    25,    11,    94,    95,     0,     0,
+      96,     0,    49,    97,     0,     0,     0,   110,   111,     0,
+       0,     0,   103,    98,   101,     0,     0,     0,     0,     0,
+       0,     0,     0,     0,     0,    99,     7,    72,    80,    81,
+      28,    30,     0,   107,     0,     0,    65,     0,     0,     0,
+       0,     9,    10,     0,     0,     0,     0,     0,    92,     0,
+       0,     0,    45,     0,    38,    37,    33,    34,     0,    36,
+      35,     0,     0,    92,     0,    57,    58,    54,    56,    55,
+      64,    52,    51,    69,    71,    67,    70,    66,    87,    88,
+      86,    77,    79,    75,    78,    74,   100,   106,   108,   109,
+     105,   104,   102,   112,    27,    83,     0,     0,     0,   101,
+       0,   101,   101,   101,     0,     0,     0,    84,    61,   101,
+       0,   101,     0,    90,    91,     0,    39,    93,     0,     0,
+     101,    47,    44,    26,     0,    60,     0,    89,    40,    41,
+      42,     0,     0,    46,    59,    62,    43,    48
 };
 
 /* YYDEFGOTO[NTERM-NUM]. */
 static const short int yydefgoto[] =
 {
-      -1,     1,     2,    25,    26,   100,    27,    28,    29,    30,
-      64,   101,   102,   148,   178,    31,    32,   116,    33,    66,
-     112,    67,    34,   120,    35,    68,    36,    37,   128,    38,
-      70,    39,    40,    41,   103,   104,    69,   105,   143,   144,
-      42,    73,   159,    59,    60
+      -1,     1,     2,    26,    27,   105,    28,    29,    30,    31,
+      67,   106,   107,   155,   183,    32,    33,   121,    34,    69,
+     117,    70,    35,   125,    36,    71,    37,    38,   133,    39,
+      73,    40,    41,    42,   108,   109,    72,   110,   150,   151,
+      43,    76,    90,    61,    62,    44
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -135
+#define YYPACT_NINF -81
 static const short int yypact[] =
 {
-    -135,     2,   170,  -135,   -14,    56,    56,    -8,    56,    24,
-      67,    56,     7,    14,    62,    97,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,   156,  -135,   166,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,   138,   151,  -135,   152,
-    -135,  -135,   163,   167,   176,  -135,  -135,    62,    62,   185,
-     -19,  -135,   188,   190,    42,   103,   194,    85,    70,   222,
-      70,   132,  -135,   191,  -135,  -135,  -135,  -135,  -135,   127,
-    -135,    62,    62,   191,   104,   104,  -135,  -135,   193,   203,
-       9,    62,    56,    56,    62,   161,   104,  -135,   196,  -135,
-    -135,  -135,  -135,   233,  -135,  -135,   204,    56,    56,   221,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
-    -135,  -135,  -135,   219,  -135,  -135,  -135,  -135,  -135,    62,
-     209,   212,   240,   224,   240,    -1,   240,   104,    41,   225,
-    -135,  -135,   240,   226,   240,   218,  -135,  -135,    62,   227,
-    -135,  -135,   228,   229,   240,   230,  -135,  -135,   231,  -135,
-     232,  -135,   112,  -135,  -135,  -135,   234,    56,  -135,  -135,
-    -135,  -135,  -135
+     -81,    39,   160,   -81,   -30,   -10,   -10,    15,   -10,    26,
+      38,   -10,    54,    55,    48,    61,   -81,   -81,   -81,   -81,
+     -81,   -81,   -81,    60,    87,   -81,    95,   -81,   -81,   -81,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,    90,    91,
+     -81,   104,   -81,   -81,   105,   116,   130,   -81,   -81,    48,
+      48,   125,     3,   -81,   158,   141,   152,    45,    94,   188,
+     231,     5,   217,     5,   124,   -81,   153,   -81,   -81,   -81,
+     -81,   -81,    56,   -81,    48,    48,   153,    -1,    -1,    48,
+     159,   -81,   -81,   163,   169,    -3,    48,   -10,   -10,    48,
+      92,    -1,   -81,   211,   -81,   -81,   -81,   -81,   216,   -81,
+     -81,   198,   -10,   -10,   208,   -81,   -81,   -81,   -81,   -81,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   204,   -81,
+     -81,   -81,     2,   -81,   -81,   -81,    48,   221,   232,   158,
+     215,   158,     9,   158,    -1,    46,   224,   -81,   -81,   158,
+     227,   158,   238,   -81,   -81,   229,   -81,   -81,   230,   235,
+     158,   233,   -81,   -81,   241,   -81,   242,   -81,   -81,   -81,
+     -81,   243,   -10,   -81,   -81,   -81,   -81,   -81
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const short int yypgoto[] =
 {
-    -135,  -135,  -135,  -135,    94,   -45,  -135,  -135,  -135,  -135,
-     237,  -135,  -135,  -135,  -135,  -135,  -135,  -135,   -54,  -135,
-    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,     1,
-    -135,  -135,  -135,  -135,  -135,   195,   235,   -44,   159,    -5,
-      98,   210,  -134,   -53,   -77
+     -81,   -81,   -81,   -81,   140,    11,   -81,   -81,   -81,   -81,
+     246,   -81,   -81,   -81,   -81,   -81,   -81,   -81,    82,   -81,
+     -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   -81,   117,
+     -81,   -81,   -81,   -81,   -81,   209,   236,    80,   166,    -5,
+     146,   219,    99,   -55,   -80,   -81
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, syntax error.  */
-#define YYTABLE_NINF -82
+#define YYTABLE_NINF -83
 static const short int yytable[] =
 {
-      46,    47,     3,    49,    79,    80,    52,   135,   136,    84,
-     161,   162,   163,   158,   119,    85,   127,    43,   168,   147,
-     170,   111,   114,    48,   124,   125,   124,   125,   133,   134,
-     176,    81,    82,    53,   139,    55,    56,   140,   141,    57,
-      54,   145,   -28,    88,    58,   -28,   -28,   -28,   -28,   -28,
-     -28,   -28,   -28,   -28,    89,    50,   -28,   -28,    90,    91,
-     -28,    92,    93,    94,    95,    96,    97,   165,    98,   121,
-     164,   129,   166,    99,     6,     7,     8,     9,    10,    11,
-      12,    13,    44,    45,    14,    15,   155,   142,    55,    56,
-       7,     8,    57,    10,    11,    12,    13,    58,    51,    14,
-      15,    24,   152,   -30,    88,   172,   -30,   -30,   -30,   -30,
-     -30,   -30,   -30,   -30,   -30,    89,    24,   -30,   -30,    90,
-      91,   -30,    92,    93,    94,    95,    96,    97,    61,    98,
-      55,    56,   -81,    88,    99,   -81,   -81,   -81,   -81,   -81,
-     -81,   -81,   -81,   -81,    81,    82,   -81,   -81,    90,    91,
-     -81,   -81,   -81,   -81,   -81,   -81,   132,    62,    98,    81,
-      82,   115,   118,   123,   126,   117,   122,    63,   130,    72,
-      -2,     4,   182,     5,     6,     7,     8,     9,    10,    11,
-      12,    13,    74,    75,    14,    15,    16,   146,    17,    18,
-      19,    20,    21,    22,    76,    88,    23,   149,    77,   -49,
-     -49,    24,   -49,   -49,   -49,   -49,    89,    78,   -49,   -49,
-      90,    91,   106,   107,   108,   109,    72,    81,    82,    86,
-      98,    87,   131,    88,   137,   110,   -72,   -72,   -72,   -72,
-     -72,   -72,   -72,   -72,   138,   151,   -72,   -72,    90,    91,
-     156,    81,    82,   157,    81,    82,   150,   154,    98,   171,
-      81,    82,    82,   123,   158,   160,   167,   169,   173,   174,
-     175,   113,   179,   180,   177,   181,    65,   153,     0,    83,
-       0,     0,     0,     0,     0,    71
+      48,    49,    45,    51,    82,    83,    54,   140,   141,     6,
+       7,     8,     9,    10,    11,    12,    13,    46,    47,    14,
+      15,   154,   146,    89,    57,    58,    57,    58,    59,   138,
+     139,    23,    87,    60,   142,    84,    85,    25,    88,     3,
+     147,   148,    84,    85,   152,   -29,    93,    50,   -29,   -29,
+     -29,   -29,   -29,   -29,   -29,   -29,   -29,    94,    52,   -29,
+     -29,    95,    96,   -29,    97,    98,    99,   100,   101,   102,
+      53,   -29,   103,   171,   170,    57,    58,   104,   172,    59,
+     116,    55,    56,   129,    60,   129,   137,    64,    65,    84,
+      85,   162,   149,    63,   -31,    93,    66,   -31,   -31,   -31,
+     -31,   -31,   -31,   -31,   -31,   -31,    94,   159,   -31,   -31,
+      95,    96,   -31,    97,    98,    99,   100,   101,   102,   153,
+     -31,   103,    75,    77,   -82,    93,   104,   -82,   -82,   -82,
+     -82,   -82,   -82,   -82,   -82,   -82,    78,    79,   -82,   -82,
+      95,    96,   -82,   -82,   -82,   -82,   -82,   -82,    80,   119,
+     -82,   103,   130,   124,   130,   132,   128,    75,    84,    85,
+      -2,     4,    81,     5,     6,     7,     8,     9,    10,    11,
+      12,    13,    89,    91,    14,    15,    16,   187,    17,    18,
+      19,    20,    21,    22,    92,   136,    23,    24,   126,    93,
+     134,   143,    25,   -50,   -50,   144,   -50,   -50,   -50,   -50,
+      94,   145,   -50,   -50,    95,    96,   111,   112,   113,   114,
+     120,   123,   156,   131,   -50,   103,   122,   127,    93,   135,
+     115,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   157,
+     158,   -73,   -73,    95,    96,   161,     7,     8,    85,    10,
+      11,    12,    13,   -73,   103,    14,    15,   166,   165,   128,
+     167,   168,   169,   163,    84,    85,   173,    23,   174,   175,
+     176,   178,   179,    25,   164,    84,    85,   180,   182,   181,
+     177,    84,    85,   184,   185,   186,    68,    74,   118,   160,
+      86
 };
 
-static const short int yycheck[] =
+static const unsigned char yycheck[] =
 {
-       5,     6,     0,     8,    57,    58,    11,    84,    85,    28,
-     144,   145,   146,    14,    68,    34,    70,    31,   152,    96,
-     154,    66,    66,    31,    69,    69,    71,    71,    81,    82,
-     164,    32,    33,    26,    25,    26,    27,    90,    91,    30,
-      26,    94,     0,     1,    35,     3,     4,     5,     6,     7,
-       8,     9,    10,    11,    12,    31,    14,    15,    16,    17,
-      18,    19,    20,    21,    22,    23,    24,    26,    26,    68,
-     147,    70,    31,    31,     4,     5,     6,     7,     8,     9,
-      10,    11,    26,    27,    14,    15,   139,    92,    26,    27,
-       5,     6,    30,     8,     9,    10,    11,    35,    31,    14,
-      15,    31,   107,     0,     1,   158,     3,     4,     5,     6,
-       7,     8,     9,    10,    11,    12,    31,    14,    15,    16,
-      17,    18,    19,    20,    21,    22,    23,    24,    31,    26,
-      26,    27,     0,     1,    31,     3,     4,     5,     6,     7,
-       8,     9,    10,    11,    32,    33,    14,    15,    16,    17,
-      18,    19,    20,    21,    22,    23,    29,     1,    26,    32,
-      33,    67,    68,    31,    70,    67,    68,     1,    70,    31,
-       0,     1,   177,     3,     4,     5,     6,     7,     8,     9,
-      10,    11,    31,    31,    14,    15,    16,    26,    18,    19,
-      20,    21,    22,    23,    31,     1,    26,     1,    31,     5,
-       6,    31,     8,     9,    10,    11,    12,    31,    14,    15,
-      16,    17,    18,    19,    20,    21,    31,    32,    33,    31,
-      26,    31,    31,     1,    31,    31,     4,     5,     6,     7,
-       8,     9,    10,    11,    31,    31,    14,    15,    16,    17,
-      31,    32,    33,    31,    32,    33,    13,    26,    26,    31,
-      32,    33,    33,    31,    14,    31,    31,    31,    31,    31,
-      31,    66,    31,    31,    34,    31,    29,   108,    -1,    59,
-      -1,    -1,    -1,    -1,    -1,    40
+       5,     6,    32,     8,    59,    60,    11,    87,    88,     4,
+       5,     6,     7,     8,     9,    10,    11,    27,    28,    14,
+      15,   101,    25,    14,    27,    28,    27,    28,    31,    84,
+      85,    26,    29,    36,    89,    33,    34,    32,    35,     0,
+      95,    96,    33,    34,    99,     0,     1,    32,     3,     4,
+       5,     6,     7,     8,     9,    10,    11,    12,    32,    14,
+      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
+      32,    26,    27,    27,   154,    27,    28,    32,    32,    31,
+      69,    27,    27,    72,    36,    74,    30,    27,     1,    33,
+      34,   146,    97,    32,     0,     1,     1,     3,     4,     5,
+       6,     7,     8,     9,    10,    11,    12,   112,    14,    15,
+      16,    17,    18,    19,    20,    21,    22,    23,    24,    27,
+      26,    27,    32,    32,     0,     1,    32,     3,     4,     5,
+       6,     7,     8,     9,    10,    11,    32,    32,    14,    15,
+      16,    17,    18,    19,    20,    21,    22,    23,    32,    69,
+      26,    27,    72,    71,    74,    73,    32,    32,    33,    34,
+       0,     1,    32,     3,     4,     5,     6,     7,     8,     9,
+      10,    11,    14,    32,    14,    15,    16,   182,    18,    19,
+      20,    21,    22,    23,    32,    32,    26,    27,    71,     1,
+      73,    32,    32,     5,     6,    32,     8,     9,    10,    11,
+      12,    32,    14,    15,    16,    17,    18,    19,    20,    21,
+      70,    71,     1,    73,    26,    27,    70,    71,     1,    73,
+      32,     4,     5,     6,     7,     8,     9,    10,    11,    13,
+      32,    14,    15,    16,    17,    27,     5,     6,    34,     8,
+       9,    10,    11,    26,    27,    14,    15,    32,   149,    32,
+     151,   152,   153,    32,    33,    34,    32,    26,   159,    32,
+     161,    32,    32,    32,    32,    33,    34,    32,    35,   170,
+      32,    33,    34,    32,    32,    32,    30,    41,    69,   113,
+      61
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const unsigned char yystos[] =
 {
-       0,    37,    38,     0,     1,     3,     4,     5,     6,     7,
+       0,    38,    39,     0,     1,     3,     4,     5,     6,     7,
        8,     9,    10,    11,    14,    15,    16,    18,    19,    20,
-      21,    22,    23,    26,    31,    39,    40,    42,    43,    44,
-      45,    51,    52,    54,    58,    60,    62,    63,    65,    67,
-      68,    69,    76,    31,    26,    27,    75,    75,    31,    75,
-      31,    31,    75,    26,    26,    26,    27,    30,    35,    79,
-      80,    31,     1,     1,    46,    46,    55,    57,    61,    72,
-      66,    72,    31,    77,    31,    31,    31,    31,    31,    79,
-      79,    32,    33,    77,    28,    34,    31,    31,     1,    12,
-      16,    17,    19,    20,    21,    22,    23,    24,    26,    31,
-      41,    47,    48,    70,    71,    73,    18,    19,    20,    21,
-      31,    41,    56,    71,    73,    40,    53,    76,    40,    54,
-      59,    65,    76,    31,    41,    73,    40,    54,    64,    65,
-      76,    31,    29,    79,    79,    80,    80,    31,    31,    25,
-      79,    79,    75,    74,    75,    79,    26,    80,    49,     1,
-      13,    31,    75,    74,    26,    79,    31,    31,    14,    78,
-      31,    78,    78,    78,    80,    26,    31,    31,    78,    31,
-      78,    31,    79,    31,    31,    31,    78,    34,    50,    31,
-      31,    31,    75
+      21,    22,    23,    26,    27,    32,    40,    41,    43,    44,
+      45,    46,    52,    53,    55,    59,    61,    63,    64,    66,
+      68,    69,    70,    77,    82,    32,    27,    28,    76,    76,
+      32,    76,    32,    32,    76,    27,    27,    27,    28,    31,
+      36,    80,    81,    32,    27,     1,     1,    47,    47,    56,
+      58,    62,    73,    67,    73,    32,    78,    32,    32,    32,
+      32,    32,    80,    80,    33,    34,    78,    29,    35,    14,
+      79,    32,    32,     1,    12,    16,    17,    19,    20,    21,
+      22,    23,    24,    27,    32,    42,    48,    49,    71,    72,
+      74,    18,    19,    20,    21,    32,    42,    57,    72,    74,
+      41,    54,    77,    41,    55,    60,    66,    77,    32,    42,
+      74,    41,    55,    65,    66,    77,    32,    30,    80,    80,
+      81,    81,    80,    32,    32,    32,    25,    80,    80,    76,
+      75,    76,    80,    27,    81,    50,     1,    13,    32,    76,
+      75,    27,    80,    32,    32,    79,    32,    79,    79,    79,
+      81,    27,    32,    32,    79,    32,    79,    32,    32,    32,
+      32,    79,    35,    51,    32,    32,    32,    76
 };
 
 #define yyerrok		(yyerrstatus = 0)
@@ -1102,7 +1108,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 
   switch (yytype)
     {
-      case 52: /* "choice_entry" */
+      case 53: /* "choice_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1112,7 +1118,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
         break;
-      case 58: /* "if_entry" */
+      case 59: /* "if_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1122,7 +1128,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
         break;
-      case 63: /* "menu_entry" */
+      case 64: /* "menu_entry" */
 
         {
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1454,17 +1460,17 @@ yyreduce:
     { zconf_error("invalid statement"); ;}
     break;
 
-  case 25:
+  case 26:
 
     { zconf_error("unknown option \"%s\"", (yyvsp[-2].string)); ;}
     break;
 
-  case 26:
+  case 27:
 
     { zconf_error("invalid option"); ;}
     break;
 
-  case 27:
+  case 28:
 
     {
 	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
@@ -1474,7 +1480,7 @@ yyreduce:
 ;}
     break;
 
-  case 28:
+  case 29:
 
     {
 	menu_end_entry();
@@ -1482,7 +1488,7 @@ yyreduce:
 ;}
     break;
 
-  case 29:
+  case 30:
 
     {
 	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
@@ -1492,7 +1498,7 @@ yyreduce:
 ;}
     break;
 
-  case 30:
+  case 31:
 
     {
 	if (current_entry->prompt)
@@ -1504,7 +1510,7 @@ yyreduce:
 ;}
     break;
 
-  case 38:
+  case 39:
 
     {
 	menu_set_type((yyvsp[-2].id)->stype);
@@ -1514,7 +1520,7 @@ yyreduce:
 ;}
     break;
 
-  case 39:
+  case 40:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1522,7 +1528,7 @@ yyreduce:
 ;}
     break;
 
-  case 40:
+  case 41:
 
     {
 	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
@@ -1534,7 +1540,7 @@ yyreduce:
 ;}
     break;
 
-  case 41:
+  case 42:
 
     {
 	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
@@ -1542,7 +1548,7 @@ yyreduce:
 ;}
     break;
 
-  case 42:
+  case 43:
 
     {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
@@ -1550,7 +1556,7 @@ yyreduce:
 ;}
     break;
 
-  case 45:
+  case 46:
 
     {
 	struct kconf_id *id = kconf_id_lookup((yyvsp[-1].string), strlen((yyvsp[-1].string)));
@@ -1562,17 +1568,17 @@ yyreduce:
 ;}
     break;
 
-  case 46:
+  case 47:
 
     { (yyval.string) = NULL; ;}
     break;
 
-  case 47:
+  case 48:
 
     { (yyval.string) = (yyvsp[0].string); ;}
     break;
 
-  case 48:
+  case 49:
 
     {
 	struct symbol *sym = sym_lookup(NULL, 0);
@@ -1583,14 +1589,14 @@ yyreduce:
 ;}
     break;
 
-  case 49:
+  case 50:
 
     {
 	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 50:
+  case 51:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_CHOICE, T_ENDCHOICE)) {
@@ -1600,7 +1606,7 @@ yyreduce:
 ;}
     break;
 
-  case 58:
+  case 59:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
@@ -1608,7 +1614,7 @@ yyreduce:
 ;}
     break;
 
-  case 59:
+  case 60:
 
     {
 	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
@@ -1621,7 +1627,7 @@ yyreduce:
 ;}
     break;
 
-  case 60:
+  case 61:
 
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
@@ -1629,7 +1635,7 @@ yyreduce:
 ;}
     break;
 
-  case 61:
+  case 62:
 
     {
 	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
@@ -1641,7 +1647,7 @@ yyreduce:
 ;}
     break;
 
-  case 64:
+  case 65:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
@@ -1651,7 +1657,7 @@ yyreduce:
 ;}
     break;
 
-  case 65:
+  case 66:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_IF, T_ENDIF)) {
@@ -1661,7 +1667,7 @@ yyreduce:
 ;}
     break;
 
-  case 71:
+  case 72:
 
     {
 	menu_add_entry(NULL);
@@ -1670,14 +1676,14 @@ yyreduce:
 ;}
     break;
 
-  case 72:
+  case 73:
 
     {
 	(yyval.menu) = menu_add_menu();
 ;}
     break;
 
-  case 73:
+  case 74:
 
     {
 	if (zconf_endtoken((yyvsp[0].id), T_MENU, T_ENDMENU)) {
@@ -1687,7 +1693,7 @@ yyreduce:
 ;}
     break;
 
-  case 79:
+  case 80:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
@@ -1695,7 +1701,7 @@ yyreduce:
 ;}
     break;
 
-  case 80:
+  case 81:
 
     {
 	menu_add_entry(NULL);
@@ -1704,14 +1710,14 @@ yyreduce:
 ;}
     break;
 
-  case 81:
+  case 82:
 
     {
 	menu_end_entry();
 ;}
     break;
 
-  case 82:
+  case 83:
 
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
@@ -1719,14 +1725,14 @@ yyreduce:
 ;}
     break;
 
-  case 83:
+  case 84:
 
     {
 	current_entry->sym->help = (yyvsp[0].string);
 ;}
     break;
 
-  case 88:
+  case 89:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1734,7 +1740,7 @@ yyreduce:
 ;}
     break;
 
-  case 89:
+  case 90:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1742,7 +1748,7 @@ yyreduce:
 ;}
     break;
 
-  case 90:
+  case 91:
 
     {
 	menu_add_dep((yyvsp[-1].expr));
@@ -1750,83 +1756,101 @@ yyreduce:
 ;}
     break;
 
-  case 92:
+  case 93:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
 ;}
     break;
 
-  case 95:
+  case 96:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 96:
+  case 97:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 97:
+  case 98:
 
     { (yyval.id) = (yyvsp[-1].id); ;}
     break;
 
-  case 100:
+  case 101:
 
     { (yyval.expr) = NULL; ;}
     break;
 
-  case 101:
+  case 102:
 
     { (yyval.expr) = (yyvsp[0].expr); ;}
     break;
 
-  case 102:
+  case 103:
 
     { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); ;}
     break;
 
-  case 103:
+  case 104:
 
     { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 104:
+  case 105:
 
     { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); ;}
     break;
 
-  case 105:
+  case 106:
 
     { (yyval.expr) = (yyvsp[-1].expr); ;}
     break;
 
-  case 106:
+  case 107:
 
     { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); ;}
     break;
 
-  case 107:
+  case 108:
 
     { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 108:
+  case 109:
 
     { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); ;}
     break;
 
-  case 109:
+  case 110:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); ;}
     break;
 
-  case 110:
+  case 111:
 
     { (yyval.symbol) = sym_lookup((yyvsp[0].string), 1); free((yyvsp[0].string)); ;}
     break;
 
+  case 112:
+
+    {
+	struct symbol *sym = sym_lookup((yyvsp[-2].string), 0);
+	struct expr *dep;
+
+	dep = (yyvsp[-1].expr);
+	if (!dep)
+		dep = expr_alloc_symbol(&symbol_yes);
+	sym->disable = expr_alloc_and(sym->disable, dep);
+	if (sym->menu) {
+		dep = expr_alloc_one(E_NOT, sym->disable);
+		sym->menu->dep = expr_alloc_and(sym->menu->dep, dep);
+	}
+	printd(DEBUG_PARSE, "%s:%d:disable\n", zconf_curname(), zconf_lineno());
+;}
+    break;
+
 
       default: break;
     }
diff -urpN linux-2.6/scripts/kconfig/zconf.y linux-2.6-patched/scripts/kconfig/zconf.y
--- linux-2.6/scripts/kconfig/zconf.y	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/scripts/kconfig/zconf.y	2006-09-05 16:57:18.000000000 +0200
@@ -1,4 +1,4 @@
-%{
+{
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
@@ -73,6 +73,7 @@ static struct menu *current_menu, *curre
 %token <id>T_RANGE
 %token <id>T_OPTION
 %token <id>T_ON
+%token <id>T_DISABLE
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
 %token T_UNEQUAL
@@ -130,6 +131,7 @@ common_stmt:
 	| config_stmt
 	| menuconfig_stmt
 	| source_stmt
+	| disable_stmt
 ;
 
 option_error:
@@ -470,6 +472,24 @@ symbol:	  T_WORD	{ $$ = sym_lookup($1, 0
 	| T_WORD_QUOTE	{ $$ = sym_lookup($1, 1); free($1); }
 ;
 
+/* disable option */
+
+disable_stmt: T_DISABLE T_WORD if_expr T_EOL
+{
+	struct symbol *sym = sym_lookup($2, 0);
+	struct expr *dep;
+
+	dep = $3;
+	if (!dep)
+		dep = expr_alloc_symbol(&symbol_yes);
+	sym->disable = expr_alloc_and(sym->disable, dep);
+	if (sym->menu) {
+		dep = expr_alloc_one(E_NOT, sym->disable);
+		sym->menu->dep = expr_alloc_and(sym->menu->dep, dep);
+	}
+	printd(DEBUG_PARSE, "%s:%d:disable\n", zconf_curname(), zconf_lineno());
+};
+
 %%
 
 void conf_parse(const char *name)
