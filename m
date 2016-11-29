From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 19:57:21 +0000
Message-ID: <20161129195721.GI2697@decadent.org.uk>
References: <20161129131922.GA31466@angband.pl>
 <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-11-29 at 08:17 -0800, Linus Torvalds wrote:
> > On Tue, Nov 29, 2016 at 8:03 AM, Michal Marek <mmarek@suse.com> wrote:
> >=20
> > The original and easily observable bug is that were are not generating
> > symbol checksums for the asm-exported symbols, so they default to 0.
> > This can be seen e.g. in the Module.symvers file. This seemed like a
> > minor issue, because with the functions written in asm, the type
> > checking is rather weak (this has been the case even before Al's
> > patches). However, there is another bug that with _some_ toolchains /
> > architectures, the checksums do not default to 0, but they are simply
> > missing in the ___kcrctab* sections and the module loader complains. We
> > can of course research into the details of the second bug, but we
> > already know that we are not generating the checksums while we should b=
e.
>=20
> So let's just say that "toolchain is buggy" and make a missing kcrctab
> entry mean zero (or mean "matches anything"). And just shut up the
> warning.
>=20
> I do *not* want to add random bandaids for something like a broken
> toolchain issue when I'd really rather just delete the feature.

If the modversion is missing then the fallback should be to a full
vermagic match, i.e. including the release string.  Something like
this (untested):

diff --git a/init/Kconfig b/init/Kconfig
index c4fbc1e55c25..34407f15e6d3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1945,7 +1945,6 @@ config MODULE_FORCE_UNLOAD
=20
 config MODVERSIONS
 	bool "Module versioning support"
-	depends on BROKEN
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff --git a/kernel/module.c b/kernel/module.c
index f57dd63186e6..78d61ae50bc5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -296,6 +296,12 @@ int unregister_module_notifier(struct notifier_block *=
nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
=20
+enum {
+	MAGIC_NO_MATCH,
+	MAGIC_MATCH_NEED_CRC,
+	MAGIC_MATCH_EXACT
+};
+
 struct load_info {
 	Elf_Ehdr *hdr;
 	unsigned long len;
@@ -305,6 +311,7 @@ struct load_info {
 	struct _ddebug *debug;
 	unsigned int num_debug;
 	bool sig_ok;
+	int magic_match;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
 #endif
@@ -1268,13 +1275,14 @@ static unsigned long maybe_relocated(unsigned long =
crc,
 	return crc;
 }
=20
-static int check_version(Elf_Shdr *sechdrs,
-			 unsigned int versindex,
+static int check_version(const struct load_info *info,
 			 const char *symname,
 			 struct module *mod,
 			 const unsigned long *crc,
 			 const struct module *crc_owner)
 {
+	Elf_Shdr *sechdrs =3D info->sechdrs;
+	unsigned int versindex =3D info->index.vers;
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
=20
@@ -1294,6 +1302,10 @@ static int check_version(Elf_Shdr *sechdrs,
 		if (strcmp(versions[i].name, symname) !=3D 0)
 			continue;
=20
+		/* Ignore dummy zero CRC */
+		if (versions[i].crc =3D=3D 0)
+			break;
+
 		if (versions[i].crc =3D=3D maybe_relocated(*crc, crc_owner))
 			return 1;
 		pr_debug("Found checksum %lX vs module %lX\n",
@@ -1301,6 +1313,9 @@ static int check_version(Elf_Shdr *sechdrs,
 		goto bad_version;
 	}
=20
+	if (info->magic_match =3D=3D MAGIC_MATCH_EXACT)
+		return 1;
+
 	pr_warn("%s: no symbol version for %s\n", mod->name, symname);
 	return 0;
=20
@@ -1310,8 +1325,7 @@ static int check_version(Elf_Shdr *sechdrs,
 	return 0;
 }
=20
-static inline int check_modstruct_version(Elf_Shdr *sechdrs,
-					  unsigned int versindex,
+static inline int check_modstruct_version(const struct load_info *info,
 					  struct module *mod)
 {
 	const unsigned long *crc;
@@ -1327,24 +1341,24 @@ static inline int check_modstruct_version(Elf_Shdr =
*sechdrs,
 		BUG();
 	}
 	preempt_enable();
-	return check_version(sechdrs, versindex,
+	return check_version(info,
 			     VMLINUX_SYMBOL_STR(module_layout), mod, crc,
 			     NULL);
 }
=20
-/* First part is kernel version, which we ignore if module has crcs. */
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
+/* First part is kernel version, which can be ignored if module has crcs. =
*/
+static inline int compare_magic(const char *amagic, const char *bmagic)
 {
-	if (has_crcs) {
-		amagic +=3D strcspn(amagic, " ");
-		bmagic +=3D strcspn(bmagic, " ");
-	}
-	return strcmp(amagic, bmagic) =3D=3D 0;
+	if (strcmp(amagic, bmagic) =3D=3D 0)
+		return MAGIC_MATCH_EXACT;
+
+	amagic +=3D strcspn(amagic, " ");
+	bmagic +=3D strcspn(bmagic, " ");
+	return strcmp(amagic, bmagic) =3D=3D 0 ? MAGIC_MATCH_NEED_CRC : MAGIC_NO_=
MATCH;
 }
+
 #else
-static inline int check_version(Elf_Shdr *sechdrs,
-				unsigned int versindex,
+static inline int check_version(const struct load_info *info,
 				const char *symname,
 				struct module *mod,
 				const unsigned long *crc,
@@ -1353,17 +1367,15 @@ static inline int check_version(Elf_Shdr *sechdrs,
 	return 1;
 }
=20
-static inline int check_modstruct_version(Elf_Shdr *sechdrs,
-					  unsigned int versindex,
+static inline int check_modstruct_version(const struct load_info *info,
 					  struct module *mod)
 {
 	return 1;
 }
=20
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
+static inline int compare_magic(const char *amagic, const char *bmagic)
 {
-	return strcmp(amagic, bmagic) =3D=3D 0;
+	return strcmp(amagic, bmagic) =3D=3D 0 ? MAGIC_MATCH_EXACT : MAGIC_NO_MAT=
CH;
 }
 #endif /* CONFIG_MODVERSIONS */
=20
@@ -1390,8 +1402,7 @@ static const struct kernel_symbol *resolve_symbol(str=
uct module *mod,
 	if (!sym)
 		goto unlock;
=20
-	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc,
-			   owner)) {
+	if (!check_version(info, name, mod, crc, owner)) {
 		sym =3D ERR_PTR(-EINVAL);
 		goto getname;
 	}
@@ -2936,7 +2947,7 @@ static struct module *setup_load_info(struct load_inf=
o *info, int flags)
 	info->index.pcpu =3D find_pcpusec(info);
=20
 	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info->sechdrs, info->index.vers, mod))
+	if (!check_modstruct_version(info, mod))
 		return ERR_PTR(-ENOEXEC);
=20
 	return mod;
@@ -2952,13 +2963,19 @@ static int check_modinfo(struct module *mod, struct=
 load_info *info, int flags)
=20
 	/* This is allowed: modprobe --force will invalidate it. */
 	if (!modmagic) {
+		info->magic_match =3D MAGIC_NO_MATCH;
 		err =3D try_to_force_load(mod, "bad vermagic");
 		if (err)
 			return err;
-	} else if (!same_magic(modmagic, vermagic, info->index.vers)) {
-		pr_err("%s: version magic '%s' should be '%s'\n",
-		       mod->name, modmagic, vermagic);
-		return -ENOEXEC;
+	} else {
+		info->magic_match =3D compare_magic(modmagic, vermagic);
+		if (info->magic_match =3D=3D MAGIC_NO_MATCH ||
+		    (info->magic_match =3D=3D MAGIC_MATCH_NEED_CRC &&
+		     !info->index.vers)) {
+			pr_err("%s: version magic '%s' should be '%s'\n",
+			       mod->name, modmagic, vermagic);
+			return -ENOEXEC;
+		}
 	}
=20
 	if (!get_modinfo(info, "intree")) {
--- END ---

Ben.

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0- John Levine, moderator of comp.compilers

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIUAwUBWD3doOe/yOyVhhEJAQrJiw/4k111hMHMZxTv8gfkR0zX/1FtwBtuO+mr
Sa2KiRlJeQsn3asb7HuvU8VTU7TfsL8TLrFae314gIz7zpMAvg1tbH5PHxqDxkvy
fIS8zJtCNsDGqbkJYUpQfEEOZic7l//taxw4Pb32k9i9YKIEBZ7zixfZzGySemQZ
EnnaXwv7grpM4nTrdp7lD/pT6qmFlvJPz5qc5qVHvHDa23uY28etiq2v9JMq0Jjl
FrR2+REpyla4B1SU6kkBD6mWImYp6Nhc5ID0tTiZ04bpfWXHc2XRiESszh1KOYOS
Py1+v2bJ7l7/hh5Hi6e5joTGjG6tEWGQTd+re248B4ydu+qKcnV6A+g/BwhoDWHj
Ap1kAXHC9f8IOxEaQrFZ4+BQtH7m9mp6+Y0oKFuxfn4BcEDLYvYIxbuTLIVRDfMg
lm1lJJq5+Jc3+MtcCjHp8ENTSfoBcvCkhVzn4iu0K1gzfJuwA0JQPytjqHH/4q2V
ngdqYIXJL5074LUf+CioZg5GWuBhu502iJcwqw2Js98+VMcgASW1IZT3TPK+gxMk
8DFIB5Fd7dgXjJLCIxEJPS4e6AQY75p7Zczgv82xvj5kr7lQmOhgWbxBrrl2vSAQ
gNUkHpo26GuXk7pZ+EUnitzW2Rwp5YYU9mTlaeSNf4+vwvKamghWcW8n/veD0UWE
AC0RfqiQaA==
=zqRc
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
