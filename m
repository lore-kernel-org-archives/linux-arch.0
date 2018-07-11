Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:50649 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeGKRF1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jul 2018 13:05:27 -0400
Message-ID: <1531328187.13297.35.camel@intel.com>
Subject: Re: [RFC PATCH v2 23/27] mm/mmap: Add IBT bitmap size to address
 space limit check
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 11 Jul 2018 09:56:27 -0700
In-Reply-To: <7cdadb28-a9aa-550b-9e31-30691b64b504@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-24-yu-cheng.yu@intel.com>
         <7cdadb28-a9aa-550b-9e31-30691b64b504@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180711165627.sY1ExZLGyPiA7wSEZgabGXtp-T_aARNAYADx1Nl3lPc@z>

On Tue, 2018-07-10 at 16:57 -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > 
> > The indirect branch tracking legacy bitmap takes a large address
> > space.  This causes may_expand_vm() failure on the address limit
> > check.  For a IBT-enabled task, add the bitmap size to the
> > address limit.
> This appears to require that we set up
> current->thread.cet.ibt_bitmap_size _before_ calling may_expand_vm().
> What keeps the ibt_mmap() itself from hitting the address limit?

Yes, that is overlooked.  I will fix it.

Thanks,
Yu-cheng
