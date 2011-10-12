From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/7] Add assertion checking macros
Date: Wed, 12 Oct 2011 21:36:16 +0100
Message-ID: <4874.1318451776@redhat.com>
References: <4E95D1B7.4050603@gmail.com> <20111012164717.539.44368.stgit@warthog.procyon.org.uk> <20111012164728.539.29820.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab1JLUhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Oct 2011 16:37:22 -0400
In-Reply-To: <4E95D1B7.4050603@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:

> Hmm, but why not have a single something-like-"ASSERT" doing the same as
> in userspace:

Because I want to print the values that were checked.  Your suggestion merely
turns the unevaluated expression into a string and prints that.  The values
are very useful to know in debugging the problem.

David
