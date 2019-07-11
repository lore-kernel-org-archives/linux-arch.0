Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:49221 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfGKIXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 04:23:20 -0400
Date: Thu, 11 Jul 2019 10:23:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
In-Reply-To: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1907111022400.1889@nanos.tec.linutronix.de>
References: <20190711030339.20892-1-npiggin@gmail.com> <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, 11 Jul 2019, Christopher Lameter wrote:

> On Thu, 11 Jul 2019, Nicholas Piggin wrote:
> 
> > Remove page table allocator "quicklists". These have been around for a
> > long time, but have not got much traction in the last decade and are
> > only used on ia64 and sh architectures.
> 
> I also think its good to remove this code. Note sure though if IA64
> may still have a need of it. But then its not clear that the IA64 arch is
> still in use. Is it still maintained?

It's kept alive
