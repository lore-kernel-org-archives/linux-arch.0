Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36051 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751248AbdGQFp2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jul 2017 01:45:28 -0400
Subject: Re: [PATCH 3/8] x86/xen: Redefine XEN_ELFNOTE_INIT_P2M using PUD_SIZE
 * PTRS_PER_PUD
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
 <20170716225954.74185-4-kirill.shutemov@linux.intel.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <de750662-faee-ce5b-526e-3f03ab87419d@suse.com>
Date: Mon, 17 Jul 2017 07:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170716225954.74185-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170717054524.l6onGuiFEZqdSUaf5wPHjYQQ90fHu8sMRDx8hJSlgYc@z>

On 17/07/17 00:59, Kirill A. Shutemov wrote:
> XEN_ELFNOTE_INIT_P2M has to be 512GB for both 4- and 5-level paging.
> (PUD_SIZE * PTRS_PER_PUD) would do this.
> 
> Unfortunately, we cannot use P4D_SIZE, which would fit here. With
> current headers structure it cannot be used in assembly, if p4d
> level is folded.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Thanks,

Juergen
