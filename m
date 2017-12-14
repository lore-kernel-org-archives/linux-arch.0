From: David Howells <dhowells@redhat.com>
Subject: Re: Adding init_task consolidation patches to linux-next
Date: Thu, 14 Dec 2017 18:21:16 +0000
Message-ID: <18931.1513275676@warthog.procyon.org.uk>
References: <20171211070805.07adcb43@canb.auug.org.au> <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <10228.1512748600@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171211070805.07adcb43@canb.auug.org.au>
Content-ID: <18930.1513275676.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I'd be much happier if these patches had any Reviewd-by or Tested-by tags ...

They've now got:

	Tested-by: Tony Luck <tony.luck@intel.com>
	Tested-by: Will Deacon <will.deacon@arm.com> (arm64)

attached.  I've also added riscv support.

David
