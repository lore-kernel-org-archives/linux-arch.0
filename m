Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:43744 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbXGJP5J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 11:57:09 -0400
Message-ID: <4693AB6F.9030804@zytor.com>
Date: Tue, 10 Jul 2007 08:53:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [x86 setup 13/33] Header file to produce 16-bit code with gcc
References: <11840359321823-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <108510B6-B9BE-49D4-BDCA-E25CA20CB29B@kernel.crashing.org> <200707101721.58937.ak@suse.de> <4693AA56.9040109@zytor.com>
In-Reply-To: <4693AA56.9040109@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

H. Peter Anvin wrote:
> 
> I'm a bit surprised about the claim w.r.t. -fno-unit-at-a-time (although
> I guess that is the default and one would thus typically not see this.)
>  Got any pointers why that would cause a global asm() to be scrambled
> around?
> 

Never mind.  It's quite right there in the gcc doc, and
-fno-unit-at-a-time is documented as the fix.

	-hpa
