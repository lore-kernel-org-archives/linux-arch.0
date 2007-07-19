Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38220 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934224AbXGSRCB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 13:02:01 -0400
Message-ID: <469F976C.6090007@zytor.com>
Date: Thu, 19 Jul 2007 09:55:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 059/209] mm: variable length argument support
References: <200707190848.l6J8mGmT023102@imap1.linux-foundation.org> <alpine.LFD.0.999.0707190937290.8502@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707190937290.8502@woody.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, aaw@google.com, a.p.zijlstra@chello.nl, bunk@stusta.de, hugh@veritas.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> 
> On Thu, 19 Jul 2007, akpm@linux-foundation.org wrote:
>> From: Ollie Wild <aaw@google.com>
>>
>> Remove the arg+env limit of MAX_ARG_PAGES by copying the strings directly from
>> the old mm into the new mm.
> 
> Btw, this is just a note to say "thanks". 
> 

Indeed.  This is a very frustrating limitation which has finally been
lifted.

	-hpa
