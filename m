Return-Path: <owner-linux-mm@kvack.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 5/7] x86/cet/ibt: Add arch_prctl functions for Indirect
 Branch Tracking
Date: Wed,  5 Feb 2020 10:23:06 -0800
Message-ID: <20200205182308.4028-6-yu-cheng.yu@intel.com>
In-Reply-To: <20200205182308.4028-1-yu-cheng.yu@intel.com>
References: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205182306.r3YCSV2FmjG_g7qGeQ0MVFsFacjE8905YzZfnGJmENw@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE for Indirect Branch
Tracking.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/cet_prctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 6cf8f87e3d98..2a3170786a3b 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -20,6 +20,8 @@ static int handle_get_status(unsigned long arg2)
=20
 	if (cet->shstk_enabled)
 		features |=3D GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+	if (cet->ibt_enabled)
+		features |=3D GNU_PROPERTY_X86_FEATURE_1_IBT;
=20
 	buf[0] =3D (unsigned long)features;
 	buf[1] =3D cet->shstk_base;
@@ -68,6 +70,8 @@ int prctl_cet(int option, unsigned long arg2)
 			return -EPERM;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			cet_disable_free_shstk(current);
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			cet_disable_ibt();
=20
 		return 0;
=20
--=20
2.21.0
