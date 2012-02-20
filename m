From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] Adjust the comment on get_order() to describe the
 size==0 case
Date: Mon, 20 Feb 2012 13:22:07 -0800
Message-ID: <4F42B97F.6000808@zytor.com>
References: <201112201509.21334.arnd@arndb.de> <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <20111213145704.14362.62471.stgit@warthog.procyon.org.uk> <4EEF8652.5060201@zytor.com> <14925.1324395565@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:37539 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab2BTVWk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Feb 2012 16:22:40 -0500
In-Reply-To: <14925.1324395565@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On 12/20/2011 07:39 AM, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> I generally prefer asm-generic patches to go through the trees that are
>> most interested in them (with my ack), which keeps the series close together
>> and lets me not maintain a separate tree for asm-generic most of the time.
> 
> Should I resubmit the latter two patches detached from the first with the
> Acked-bys added?
> 
> David

[Resurrecting an old thread from before hpa 2.0]

Yes please, I never received them...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
