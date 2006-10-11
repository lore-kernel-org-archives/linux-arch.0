Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:12951 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161014AbWJKIA3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Oct 2006 04:00:29 -0400
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 10:00:21 +0200
Message-Id: <1160553621.3000.355.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Ollie Wild <aaw@google.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-10-10 at 17:05 -0700, Ollie Wild wrote:

on first sight it looks like you pin the entire userspace buffer at the
same time (but I can misread the code; this stuff is a bit of a
spaghetti by nature); that would be a DoS scenario if true...


 -- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

