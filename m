Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbXHNJnt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Aug 2007 05:43:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070813111559.GG24018@shell.boston.redhat.com>
References: <20070813111559.GG24018@shell.boston.redhat.com> <46C03885.7000109@redhat.com>
Subject: Re: [PATCH 7/23] make atomic_read() and atomic_set() behavior consistent on frv
Date: Tue, 14 Aug 2007 10:42:31 +0100
Message-ID: <1205.1187084551@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, Segher Boessenkool <segher@kernel.crashing.org>, "Luck, Tony" <tony.luck@intel.com>, Chris Friesen <cfriesen@nortel.com>, "Robert P. J. Day" <rpjday@mindspring.com>
List-ID: <linux-arch.vger.kernel.org>

Chris Snook <csnook@redhat.com> wrote:

> Use volatile consistently in atomic.h on frv.

Acked-By: David Howells <dhowells@redhat.com>
