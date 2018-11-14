Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:47752 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOGcv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Nov 2018 01:32:51 -0500
Date: Wed, 14 Nov 2018 21:28:02 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 06/27] x86/cet: Control protection exception handler
Message-ID: <20181114202802.GN13926@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-7-yu-cheng.yu@intel.com>
 <20181114184436.GK13926@zn.tnic>
 <307b6162b0270871e664ca88a96b4ea0d1b3f65b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <307b6162b0270871e664ca88a96b4ea0d1b3f65b.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181114202802.4y5FDeNB_-E30aNAjzNwvZ0UpxZzfkDBCbxhtARX6-Y@z>

On Wed, Nov 14, 2018 at 12:19:42PM -0800, Yu-cheng Yu wrote:
> Yes, I was not sure if the addition should follow the existing style (which does
> not have identifier names).  What do you think is right?

Yeah, we've converted them all now to named params:

https://git.kernel.org/tip/8e1599fcac2efda8b7d433ef69d2492f0b351e3f

It probably would be easier if you redo your patchset ontop of current
tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
