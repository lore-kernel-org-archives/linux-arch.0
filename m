Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33587 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeH3TxI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 15:53:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so16308215oip.0
        for <linux-arch@vger.kernel.org>; Thu, 30 Aug 2018 08:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
In-Reply-To: <20180830143904.3168-13-yu-cheng.yu@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Aug 2018 17:49:53 +0200
Message-ID: <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yu-cheng.yu@intel.com
Cc: the arch/x86 maintainers <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com, Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Message-ID: <20180830154953.5bMMPvsbzq6F07xUtCQuKlWEcFmA1HMWRWS5erK-ofo@z>

On Thu, Aug 30, 2018 at 4:43 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When Shadow Stack is enabled, the read-only and PAGE_DIRTY_HW PTE
> setting is reserved only for the Shadow Stack.  To track dirty of
> non-Shadow Stack read-only PTEs, we use PAGE_DIRTY_SW.
>
> Update ptep_set_wrprotect() and pmdp_set_wrprotect().
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 4d50de77ea96..556ef258eeff 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1203,7 +1203,28 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
>  {
> +       pte_t pte;
> +
>         clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       pte = *ptep;
> +
> +       /*
> +        * Some processors can start a write, but ending up seeing
> +        * a read-only PTE by the time they get to the Dirty bit.
> +        * In this case, they will set the Dirty bit, leaving a
> +        * read-only, Dirty PTE which looks like a Shadow Stack PTE.
> +        *
> +        * However, this behavior has been improved and will not occur
> +        * on processors supporting Shadow Stacks.  Without this
> +        * guarantee, a transition to a non-present PTE and flush the
> +        * TLB would be needed.
> +        *
> +        * When change a writable PTE to read-only and if the PTE has
> +        * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so
> +        * that the PTE is not a valid Shadow Stack PTE.
> +        */
> +       pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> +       set_pte_at(mm, addr, ptep, pte);
>  }

I don't understand why it's okay that you first atomically clear the
RW bit, then atomically switch from DIRTY_HW to DIRTY_SW. Doesn't that
mean that between the two atomic writes, another core can incorrectly
see a shadow stack?
