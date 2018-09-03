Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33328 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeICHPY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Sep 2018 03:15:24 -0400
Subject: Re: [RFC PATCH v3 05/24] Documentation/x86: Add CET description
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
 <20180830143904.3168-6-yu-cheng.yu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <709e5e6c-dab1-7a20-9641-b36a0867c006@infradead.org>
Date: Sun, 2 Sep 2018 19:56:55 -0700
MIME-Version: 1.0
In-Reply-To: <20180830143904.3168-6-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180903025655.qvWrZ31CuLU6zcwn8TzSKJanToGOADWjJCs3nHCxPLM@z>

Hi,

One spello:

On 08/30/2018 07:38 AM, Yu-cheng Yu wrote:

> diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
> new file mode 100644
> index 000000000000..337baa1f6980
> --- /dev/null
> +++ b/Documentation/x86/intel_cet.rst
> @@ -0,0 +1,252 @@
> +=========================================
> +Control Flow Enforcement Technology (CET)
> +=========================================
> +
> +[1] Overview
> +============
> +
> +Control Flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programing (ROP) attacks.  It can be implemented

                        programming

> +to protect both the kernel and applications.  In the first phase,
> +only the user-mode protection is implemented for the 64-bit kernel.
> +Thirty-two bit applications are supported under the compatibility
> +mode.


-- 
~Randy
