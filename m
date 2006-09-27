Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:15753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751206AbWI0QSi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Sep 2006 12:18:38 -0400
Date: Wed, 27 Sep 2006 09:18:30 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [PATCH] Fix zeroing on exception in copy_*_user
Message-Id: <20060927091830.a4c75810.akpm@osdl.org>
In-Reply-To: <1159349492.24891.16.camel@localhost>
References: <20060926171150.bab8a5c1.akpm@osdl.org>
	<1159349492.24891.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 27 Sep 2006 11:31:32 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Tue, 2006-09-26 at 17:11 -0700, Andrew Morton wrote:
> > I guess other architectures will need to do this.  See
> > 01408c4939479ec46c15aa7ef6e2406be50eeeca and
> > 7c12d81134b130ccd4c286b434ca48c4cda71a2f for the rationale.
> 
> Urgh, s390 does not have the problem that is does pad the leftover bytes
> in __copy_from_user_inatomic but that is does NOT pad the leftover bytes
> in __copy_from_user ..
> 

That permits users to read uninitialised kernel memory by appending to a file
from a bad address then reading the result back....
