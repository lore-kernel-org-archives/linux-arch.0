Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22619 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732340AbeGJWyN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Jul 2018 18:54:13 -0400
Subject: Re: [RFC PATCH v2 12/27] x86/mm: Shadow stack page fault error
 checking
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-13-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <61793360-f37c-ec19-c390-abe3c76a5f5c@linux.intel.com>
Date: Tue, 10 Jul 2018 15:52:55 -0700
MIME-Version: 1.0
In-Reply-To: <20180710222639.8241-13-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180710225255.c9MgjCw1wadaNVUBIJ16-VdJq9XQjXRiHv7LkrD1q_g@z>

On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> +++ b/arch/x86/include/asm/traps.h
> @@ -157,6 +157,7 @@ enum {
>   *   bit 3 ==				1: use of reserved bit detected
>   *   bit 4 ==				1: fault was an instruction fetch
>   *   bit 5 ==				1: protection keys block access
> + *   bit 6 ==				1: shadow stack access fault
>   */

Could we document this bit better?

Is this a fault where the *processor* thought it should be a shadow
stack fault?  Or is it also set on faults to valid shadow stack PTEs
that just happen to fault for other reasons, say protection keys?
