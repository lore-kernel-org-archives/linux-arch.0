From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next 1/6] bpf: implement BPF ring buffer and
 verifier support for it
Date: Thu, 14 May 2020 12:18:48 -0700
Message-ID: <20200514121848.052966b3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200513192532.4058934-1-andriin@fb.com>
        <20200513192532.4058934-2-andriin@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgENTSw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 15:18:52 -0400
In-Reply-To: <20200513192532.4058934-2-andriin@fb.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrii Nakryiko <andriin@fb.com>, linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com, "Paul E . McKenney" <paulmck@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>

On Wed, 13 May 2020 12:25:27 -0700 Andrii Nakryiko wrote:
> One interesting implementation bit, that significantly simplifies (and thus
> speeds up as well) implementation of both producers and consumers is how data
> area is mapped twice contiguously back-to-back in the virtual memory. This
> allows to not take any special measures for samples that have to wrap around
> at the end of the circular buffer data area, because the next page after the
> last data page would be first data page again, and thus the sample will still
> appear completely contiguous in virtual memory. See comment and a simple ASCII
> diagram showing this visually in bpf_ringbuf_area_alloc().

Out of curiosity - is this 100% okay to do in the kernel and user space
these days? Is this bit part of the uAPI in case we need to back out of
it? 

In the olden days virtually mapped/tagged caches could get confused
seeing the same physical memory have two active virtual mappings, or 
at least that's what I've been told in school :)

Checking with Paul - he says that could have been the case for Itanium
and PA-RISC CPUs.
