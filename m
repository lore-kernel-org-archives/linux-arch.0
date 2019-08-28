Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1Jzz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 05:55:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so2090083wml.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2019 02:55:51 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:55:46 +0100
From: Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v3 04/11] modpost: add support for symbol namespaces
Message-ID: <20190828095546.GA38321@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-5-maennich@google.com>
 <20190826162138.GA31739@linux-8ccs>
 <20190827144117.GB102829@google.com>
 <20190828094325.GA25048@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828094325.GA25048@linux-8ccs>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jessica Yu <jeyu@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@android.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
Message-ID: <20190828095546.fYotRHZrknBH52inXUEcYdEAglUaiRj35OZ9EbEfl2s@z>

On Wed, Aug 28, 2019 at 11:43:26AM +0200, Jessica Yu wrote:
>+++ Matthias Maennich [27/08/19 15:41 +0100]:
>>On Mon, Aug 26, 2019 at 06:21:38PM +0200, Jessica Yu wrote:
>>>+++ Matthias Maennich [21/08/19 12:49 +0100]:
>>>>Add support for symbols that are exported into namespaces. For that,
>>>>extract any namespace suffix from the symbol name. In addition, emit a
>>>>warning whenever a module refers to an exported symbol without
>>>>explicitly importing the namespace that it is defined in. This patch
>>>>consistently adds the namespace suffix to symbol names exported into
>>>>Module.symvers.
>>>>
>>>>Example warning emitted by modpost in case of the above violation:
>>>>
>>>>WARNING: module ums-usbat uses symbol usb_stor_resume from namespace
>>>>USB_STORAGE, but does not import it.
>>>>
>>>>Co-developed-by: Martijn Coenen <maco@android.com>
>>>>Signed-off-by: Martijn Coenen <maco@android.com>
>>>>Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>Signed-off-by: Matthias Maennich <maennich@google.com>
>>>>---
>>>>scripts/mod/modpost.c | 91 +++++++++++++++++++++++++++++++++++++------
>>>>scripts/mod/modpost.h |  7 ++++
>>>>2 files changed, 87 insertions(+), 11 deletions(-)
>>>>
>>>>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>>>index f277e116e0eb..538bb24ffee3 100644
>>>>--- a/scripts/mod/modpost.c
>>>>+++ b/scripts/mod/modpost.c
>>>>@@ -164,6 +164,7 @@ struct symbol {
>>>>	struct module *module;
>>>>	unsigned int crc;
>>>>	int crc_valid;
>>>>+	const char *namespace;
>>>>	unsigned int weak:1;
>>>>	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
>>>>	unsigned int kernel:1;     /* 1 if symbol is from kernel
>>>>@@ -233,6 +234,37 @@ static struct symbol *find_symbol(const char *name)
>>>>	return NULL;
>>>>}
>>>>
>>>>+static bool contains_namespace(struct namespace_list *list,
>>>>+			       const char *namespace)
>>>>+{
>>>>+	struct namespace_list *ns_entry;
>>>>+
>>>>+	for (ns_entry = list; ns_entry != NULL; ns_entry = ns_entry->next)
>>>>+		if (strcmp(ns_entry->namespace, namespace) == 0)
>>>>+			return true;
>>>>+
>>>>+	return false;
>>>>+}
>>>>+
>>>>+static void add_namespace(struct namespace_list **list, const char *namespace)
>>>>+{
>>>>+	struct namespace_list *ns_entry;
>>>>+
>>>>+	if (!contains_namespace(*list, namespace)) {
>>>>+		ns_entry = NOFAIL(malloc(sizeof(struct namespace_list) +
>>>>+					 strlen(namespace) + 1));
>>>>+		strcpy(ns_entry->namespace, namespace);
>>>>+		ns_entry->next = *list;
>>>>+		*list = ns_entry;
>>>>+	}
>>>>+}
>>>>+
>>>>+static bool module_imports_namespace(struct module *module,
>>>>+				     const char *namespace)
>>>>+{
>>>>+	return contains_namespace(module->imported_namespaces, namespace);
>>>>+}
>>>>+
>>>>static const struct {
>>>>	const char *str;
>>>>	enum export export;
>>>>@@ -312,6 +344,22 @@ static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
>>>>		return export_unknown;
>>>>}
>>>>
>>>>+static const char *sym_extract_namespace(const char **symname)
>>>>+{
>>>>+	size_t n;
>>>>+	char *dupsymname;
>>>>+
>>>>+	n = strcspn(*symname, ".");
>>>>+	if (n < strlen(*symname) - 1) {
>>>>+		dupsymname = NOFAIL(strdup(*symname));
>>>>+		dupsymname[n] = '\0';
>>>>+		*symname = dupsymname;
>>>>+		return dupsymname + n + 1;
>>>>+	}
>>>>+
>>>>+	return NULL;
>>>>+}
>>>>+
>>>>/**
>>>>* Add an exported symbol - it may have already been added without a
>>>>* CRC, in this case just update the CRC
>>>>@@ -319,16 +367,18 @@ static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
>>>>static struct symbol *sym_add_exported(const char *name, struct module *mod,
>>>>				       enum export export)
>>>>{
>>>>-	struct symbol *s = find_symbol(name);
>>>>+	const char *symbol_name = name;
>>>>+	const char *namespace = sym_extract_namespace(&symbol_name);
>>>>+	struct symbol *s = find_symbol(symbol_name);
>>>>
>>>>	if (!s) {
>>>>-		s = new_symbol(name, mod, export);
>>>>+		s = new_symbol(symbol_name, mod, export);
>>>>+		s->namespace = namespace;
>>>>	} else {
>>>>		if (!s->preloaded) {
>>>>-			warn("%s: '%s' exported twice. Previous export "
>>>>-			     "was in %s%s\n", mod->name, name,
>>>>-			     s->module->name,
>>>>-			     is_vmlinux(s->module->name) ?"":".ko");
>>>>+			warn("%s: '%s' exported twice. Previous export was in %s%s\n",
>>>>+			     mod->name, symbol_name, s->module->name,
>>>>+			     is_vmlinux(s->module->name) ? "" : ".ko");
>>>>		} else {
>>>>			/* In case Module.symvers was out of date */
>>>>			s->module = mod;
>>>>@@ -1943,6 +1993,7 @@ static void read_symbols(const char *modname)
>>>>	const char *symname;
>>>>	char *version;
>>>>	char *license;
>>>>+	char *namespace;
>>>>	struct module *mod;
>>>>	struct elf_info info = { };
>>>>	Elf_Sym *sym;
>>>>@@ -1974,6 +2025,12 @@ static void read_symbols(const char *modname)
>>>>		license = get_next_modinfo(&info, "license", license);
>>>>	}
>>>>
>>>>+	namespace = get_modinfo(&info, "import_ns");
>>>>+	while (namespace) {
>>>>+		add_namespace(&mod->imported_namespaces, namespace);
>>>>+		namespace = get_next_modinfo(&info, "import_ns", namespace);
>>>>+	}
>>>>+
>>>>	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
>>>>		symname = remove_dot(info.strtab + sym->st_name);
>>>>
>>>>@@ -2118,6 +2175,13 @@ static int check_exports(struct module *mod)
>>>>			basename++;
>>>>		else
>>>>			basename = mod->name;
>>>>+
>>>>+		if (exp->namespace &&
>>>>+		    !module_imports_namespace(mod, exp->namespace)) {
>>>>+			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
>>>>+			     basename, exp->name, exp->namespace);
>>>>+		}
>>>>+
>>>>		if (!mod->gpl_compatible)
>>>>			check_for_gpl_usage(exp->export, basename, exp->name);
>>>>		check_for_unused(exp->export, basename, exp->name);
>>>>@@ -2395,16 +2459,21 @@ static void write_dump(const char *fname)
>>>>{
>>>>	struct buffer buf = { };
>>>>	struct symbol *symbol;
>>>>+	const char *namespace;
>>>>	int n;
>>>>
>>>>	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
>>>>		symbol = symbolhash[n];
>>>>		while (symbol) {
>>>>-			if (dump_sym(symbol))
>>>>-				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\n",
>>>>-					symbol->crc, symbol->name,
>>>>-					symbol->module->name,
>>>>-					export_str(symbol->export));
>>>>+			if (dump_sym(symbol)) {
>>>>+				namespace = symbol->namespace;
>>>>+				buf_printf(&buf, "0x%08x\t%s%s%s\t%s\t%s\n",
>>>>+					   symbol->crc, symbol->name,
>>>>+					   namespace ? "." : "",
>>>>+					   namespace ? namespace : "",
>>>
>>>I think it might be cleaner to just have namespace be a separate
>>>field in Module.symvers, rather than appending a dot and the
>>>namespace at the end of a symbol name. Maybe something like
>>>
>>> <crc> <symbol_name> <namespace> <module>
>>>
>>>For symbols without a namespace, we could just have "", with all
>>>fields delimited by tabs. This is just a stylistic suggestion, what do
>>>you think?
>>
>>I thought of something like that initially, but did not do it to not
>>break users of this file. But as I am anyway breaking users by changing
>>the symbol name into symbol.NS, I might as well do it as you suggested.
>>Since read_dump() also knew already how to extract the namespaces from
>>symbol.NS, it had already worked without a change to the reading code
>>of modpost. Are there any other consumers of Module.symvers that we
>>should be aware of?
>
>Maybe we can ease any possible breakage caused by the new format by
>putting the namespace column last? Then the first 4 fields crc,
>symbol, module, export type will remain in the same order, with
>namespace last. In-tree, I think we would need to update
>scripts/export_report.pl.
>
>kmod is likely to be affected too - Lucas, would the addition of a new
>field (in the order described above) in Module.symvers break any kmod tools?
>

According to the comment right above read_dump() and having a look a the
implementation of it, the format is

   0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]

So, independently of what 'something' is, also export seems to be
optional. OTOH, write_dump() seems to consistently write

   0x12345678<tab>symbol<tab>module<tab>export

Not sure if there is something modifying Module.symvers afterwards or
whether this is something that historically needs to be supported, but
if we could rule that out, I would prefer

  0x12345678<tab>symbol<tab>namespace<tab>module<tab>export

as you initially suggested.

Cheers,
Matthias
