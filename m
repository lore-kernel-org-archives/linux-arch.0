From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [guv v2 18/31] s390: Replace __get_cpu_var uses
Date: Wed, 28 Aug 2013 08:27:37 +0200
Message-ID: <20130828062737.GA10394@osiris>
References: <20130826204351.725357339@linux.com>
 <00000140bc5f0c04-e8f49653-cc6a-4841-99ca-f89e07c359ed-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:59814 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab3H1G1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2013 02:27:44 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 28 Aug 2013 07:22:37 +0100
Content-Disposition: inline
In-Reply-To: <00000140bc5f0c04-e8f49653-cc6a-4841-99ca-f89e07c359ed-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org

On Mon, Aug 26, 2013 at 08:44:40PM +0000, Christoph Lameter wrote:
> __get_cpu_var() is used for multiple purposes in the kernel source. One of them is
> address calculation via the form &__get_cpu_var(x). This calculates the address for
> the instance of the percpu variable of the current processor based on an offset.


> 4. Retrieve the content of a percpu struct
> 
> 	DEFINE_PER_CPU(struct mystruct, y);
> 	struct mystruct x = __get_cpu_var(y);
> 
>    Converts to
> 
> 	memcpy(this_cpu_ptr(&y), x, sizeof(x));

That's wrong (destination and source should be exchanged).
However your patch looks good.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
