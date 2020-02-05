Return-Path: <linux-doc-owner@vger.kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 23/27] ELF: Introduce arch_setup_elf_property()
Date: Wed,  5 Feb 2020 10:19:31 -0800
Message-ID: <20200205181935.3712-24-yu-cheng.yu@intel.com>
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Sender: linux-doc-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205181931.aP8_MjYfBrcjFvvBSFFL8UOcXCN2CuSE2d1cotPDFnM@z>

An ELF file's .note.gnu.property indicates architecture features of the
file.  These features are extracted earlier and stored in the struct
'arch_elf_state'.  Introduce arch_setup_elf_property() to setup and enabl=
e
these features.  The first use-case of this function is Shadow Stack and
Indirect Branch Tracking, which are introduced later.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 fs/binfmt_elf.c     | 4 ++++
 include/linux/elf.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 054446f93442..56fe6cd437fe 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1213,6 +1213,10 @@ static int load_elf_binary(struct linux_binprm *bp=
rm)

 	set_binfmt(&elf_format);

+	retval =3D arch_setup_elf_property(&arch_state);
+	if (retval < 0)
+		goto out;
+
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval =3D arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 7bdc6da160c7..81f2161fa4a8 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -78,9 +78,15 @@ static inline int arch_parse_elf_property(u32 type, co=
nst void *data,
 {
 	return 0;
 }
+
+static inline int arch_setup_elf_property(struct arch_elf_state *arch)
+{
+	return 0;
+}
 #else
 extern int arch_parse_elf_property(u32 type, const void *data, size_t da=
tasz,
 				   bool compat, struct arch_elf_state *arch);
+extern int arch_setup_elf_property(struct arch_elf_state *arch);
 #endif

 #endif /* _LINUX_ELF_H */
--=20
2.21.0
