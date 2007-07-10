Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:50379 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbXGJUrT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 16:47:19 -0400
Message-ID: <4693EF8E.9070403@zytor.com>
Date: Tue, 10 Jul 2007 13:43:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [x86 setup 13/33] Header file to produce 16-bit code with gcc
References: <11840359321823-git-send-email-hpa@zytor.com> <11840373002601-git-send-email-hpa@zytor.com> <108510B6-B9BE-49D4-BDCA-E25CA20CB29B@kernel.crashing.org> <200707101721.58937.ak@suse.de> <4693AA56.9040109@zytor.com> <551EA412-3D35-4BCD-ACAE-B6A7BE3CBF9B@kernel.crashing.org>
In-Reply-To: <551EA412-3D35-4BCD-ACAE-B6A7BE3CBF9B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

Segher Boessenkool wrote:
> 
>> I'm a bit surprised about the claim w.r.t. -fno-unit-at-a-time (although
>> I guess that is the default and one would thus typically not see this.)
> 
> -fno-unit-at-a-time is the default on three year old compilers,
> yes.  Newer compilers have unit-at-a-time enabled by default.
> 

As I said, never mind.  "Unit at a time" does something totally
different from what I somehow had gotten into my head it did.

	-hpa
