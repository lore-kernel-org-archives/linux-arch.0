Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46529 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932285AbeAaPmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Jan 2018 10:42:19 -0500
Date: Wed, 31 Jan 2018 16:42:05 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 11/13] kvm, x86: update spectre-v1 mitigation
In-Reply-To: <376a8a99-db4f-09ec-7c1b-a35ced6209c5@redhat.com>
Message-ID: <alpine.DEB.2.21.1801311641420.9911@nanos.tec.linutronix.de>
References: <151727412964.33451.17213780323040673404.stgit@dwillia2-desk3.amr.corp.intel.com> <151727419015.33451.13762926723789552997.stgit@dwillia2-desk3.amr.corp.intel.com> <CAPcyv4ihnC+ALbvqUWOOZ9zwBv7iy+2pBjLn9ed_duo9Z4TGKQ@mail.gmail.com>
 <alpine.DEB.2.20.1801310902180.2293@nanos> <376a8a99-db4f-09ec-7c1b-a35ced6209c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Andrew Honig <ahonig@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jim Mattson <jmattson@google.com>
Message-ID: <20180131154205.EjGOxtor05YFLlr2iSpfv-O8j5-mjGX6sXfEGgaXRUI@z>

On Wed, 31 Jan 2018, Paolo Bonzini wrote:

> On 31/01/2018 03:07, Thomas Gleixner wrote:
> >> Hi Thomas,
> >>
> >> I notice this one missing from -tip, I suspect because of the
> >> collision with the raw 'lfence' that is in current mainline? No
> >> worries, I'll send a rebased fixup to Paolo directly once
> >> array_idx_nospec() goes upstream.
> 
> Fine by me.  Also, now that x86/pti has been rebased, a version that
> replaces the lfence with array_idx_nospec() would apply to both tip and
> 4.14.

I'm happy to take it.

Thanks,

	tglx
