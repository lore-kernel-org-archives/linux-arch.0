From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] Adjust the comment on get_order() to describe the size==0 case
Date: Tue, 20 Dec 2011 15:09:21 +0000
Message-ID: <201112201509.21334.arnd@arndb.de>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <20111213145704.14362.62471.stgit@warthog.procyon.org.uk> <4EEF8652.5060201@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56509 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab1LTPJb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2011 10:09:31 -0500
In-Reply-To: <4EEF8652.5060201@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On Monday 19 December 2011, H. Peter Anvin wrote:
> Hi Arnd,
> 
> Do you want to take the 2/3 and 3/3 patches in this series (since they
> are asm-generic) or should I?
> 

I generally prefer asm-generic patches to go through the trees that are
most interested in them (with my ack), which keeps the series close together
and lets me not maintain a separate tree for asm-generic most of the time.

Please put the entire series into -tip.

Acked-by: Arnd Bergmann <arnd@arndb.de>
