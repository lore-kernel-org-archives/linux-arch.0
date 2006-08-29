Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:46754 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751237AbWH2GH7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 02:07:59 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 08:07:40 +0200
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <44F395DE.10804@yahoo.com.au>
In-Reply-To: <44F395DE.10804@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608290807.40963.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

> and chuck out the "crappy" rwsem fallback implementation

What is crappy with it?

I went with it because there were some serious concerns about
the complexity of the i386 rwsem code and so far nobody has complained
about them being too slow.

But yes rwsems could need some big cleanup.

-Andi


