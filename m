Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37891 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758878AbYDKK2m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Apr 2008 06:28:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080411.031642.193716019.davem@davemloft.net>
References: <20080411.031642.193716019.davem@davemloft.net> <1207885132.22001.85.camel@brick> <15208.1207908688@redhat.com>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 11:27:55 +0100
Message-ID: <20196.1207909675@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, harvey.harrison@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080411102755.dUPZ-LedYZAa7sbuJvD0SAXDgfzBBANd-GGviLoHpD0@z>

David Miller <davem@davemloft.net> wrote:

> No, I think it has something to do with what cases GCC is allowed to
> optimize the call inline and what cases it cannot wrt.  alignment of
> datums.

As he says in his comment, in fact.

David
