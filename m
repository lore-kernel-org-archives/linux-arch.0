From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/7] Add assertion checking macros
Date: Tue, 20 Dec 2011 15:38:05 +0000
Message-ID: <14844.1324395485@redhat.com>
References: <m21us4qjuy.fsf@firstfloor.org> <20111216141357.24668.49793.stgit@warthog.procyon.org.uk> <20111216141417.24668.15693.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab1LTPiU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Dec 2011 10:38:20 -0500
In-Reply-To: <m21us4qjuy.fsf@firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, mingo@elte.hu, linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> wrote:

> David Howells <dhowells@redhat.com> writes:
> >
> >      There is no need to display val here in the case the expression fails
> >      since it can only be 0.  If this fails, it produces an error like the
> >      following:
> >
> > 	------------[ cut here ]------------
> > 	kernel BUG at fs/fscache/main.c:109!
> > 	ASSERTION FAILED
> 
> It would be nice to display the expression here like an user space
> assert. While it can be looked up in the source it would
> make quick eyeballing easier. 
> 
> Probably wouldn't cost too much additional text size?

It can easily be made selectable.  I don't think text size should be much of
an issue - but it will also add a bunch of strings (preprocessed expressions)
to the rodata, and I'm not sure how big those can get - particularly if
they've got nested macros within (test_bit() for example).

David
