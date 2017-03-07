Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51029 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755536AbdCGSTY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 13:19:24 -0500
Subject: Re: [PATCHv4 18/33] x86/xen: convert __xen_pgd_walk() and
 xen_cleanmfnmap() to support p4d
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
 <20170306135357.3124-19-kirill.shutemov@linux.intel.com>
 <ab2868ea-1dd1-d51b-4c5a-921ef5c9a427@oracle.com>
 <20170307130009.GA2154@node>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <8bd7d5b7-7a22-a0a2-8eff-e909a1c6783e@oracle.com>
Date: Tue, 7 Mar 2017 13:18:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170307130009.GA2154@node>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, xen-devel <xen-devel@lists.xen.org>
Message-ID: <20170307181817.Kx9i4EIx6fTdgyJLg6JHPw5jynj3k9FmC-ptw2JfSEs@z>


>> Don't we need to pass vaddr down to all routines so that they select
>> appropriate tables? You seem to always be choosing the first one.
> IIUC, we clear whole page table subtree covered by one pgd entry.
> So, no, there's no need to pass vaddr down. Just pointer to page table
> entry is enough.
>
> But I know virtually nothing about Xen. Please re-check my reasoning.

Yes, we effectively remove the whole page table for vaddr so I guess
it's OK.

>
> I would also appreciate help with getting x86 Xen code work with 5-level
> paging enabled. For now I make CONFIG_XEN dependent on !CONFIG_X86_5LEVEL.

Hmmm... that's a problem since this requires changes in the hypervisor
and even if/when these changes are made older version of hypervisor
still will not be able to run those guests.

This affects only PV guests and there is a series under review that
provides clean code separation with CONFIG_XEN_PV but because, for
example, dom0 (Xen control domain) is PV this will significantly limit
availability of dom0-capable kernels (because I assume distros will want
to have CONFIG_X86_5LEVEL).


>
> Fixup:

Yes, that works. (But then it worked even without this change because
problems caused by missing the flush would be intermittent. And a joy to
debug).

-boris
