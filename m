Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:55084 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbXGJEjf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 00:39:35 -0400
Message-ID: <46930D7F.3040608@zytor.com>
Date: Mon, 09 Jul 2007 21:39:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: x86 setup code rewrite in C
References: <11840359321823-git-send-email-hpa@zytor.com> <86802c440707092124k61627732u6817b5d48dd97b88@mail.gmail.com>
In-Reply-To: <86802c440707092124k61627732u6817b5d48dd97b88@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

Yinghai Lu wrote:
> 
> is possible to put 16bit c in seperate directory. or rename them with 
> _16.c?
> 

They *ARE* in a separate directory, specifically arch/i386/boot.  All
the *.c files in there are 16 bits; the 32-bit code is in
arch/i386/boot/compressed or arch/i386/kernel.

	-hpa

