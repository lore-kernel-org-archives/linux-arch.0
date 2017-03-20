Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755908AbdCTSlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2017 14:41:16 -0400
Date: Mon, 20 Mar 2017 11:38:54 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above
 47-bits
Message-ID: <20170320183854.GB22036@bombadil.infradead.org>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
 <20170313055020.69655-27-kirill.shutemov@linux.intel.com>
 <87a88jg571.fsf@skywalker.in.ibm.com>
 <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name>
 <877f3lfzdo.fsf@skywalker.in.ibm.com>
 <CAFZ8GQx2JmEECQHEsKOymP8nDv9YHfLgcK80R75gM+r-1q-owQ@mail.gmail.com>
 <95631D05-2CA2-4967-A29E-DB396C76F62D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95631D05-2CA2-4967-A29E-DB396C76F62D@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20170320183854.VHFr7wUs6OhFKn_ukpSedg6BAxuP565oeIbjCXoUSrk@z>

On Mon, Mar 20, 2017 at 11:08:41AM -0700, hpa@zytor.com wrote:
> On March 19, 2017 1:26:58 AM PDT, "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> >On Mar 19, 2017 09:25, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> > > What is the epectation when the hint addr is below 128TB but addr + len
> > > 128TB ? Should such mmap request fail ?
> >
> >Yes, I believe so.
> 
> This *better* be conditional on some kind of settable limit.  Having a
> barrier in the middle of the address space for no apparent reason to
> "clean" software is insane.

I disagree with Kirill here.  If addr+len > 128TB, I think we should
assume the application is 57-bit aware.

Specifying hint addresses is such a rare thing to do anyway.
