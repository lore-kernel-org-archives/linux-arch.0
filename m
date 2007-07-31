Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:53156 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbXGaFLB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2007 01:11:01 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id l6V5AoG9019311
	for <linux-arch@vger.kernel.org>; Tue, 31 Jul 2007 06:10:55 +0100
Received: from py-out-1112.google.com (pyed32.prod.google.com [10.34.156.32])
	by zps35.corp.google.com with ESMTP id l6V59pUr025459
	for <linux-arch@vger.kernel.org>; Mon, 30 Jul 2007 22:10:43 -0700
Received: by py-out-1112.google.com with SMTP id d32so3123857pye
        for <linux-arch@vger.kernel.org>; Mon, 30 Jul 2007 22:10:43 -0700 (PDT)
Message-ID: <65dd6fd50707302210y5b79a70di58eb2d46f3958025@mail.gmail.com>
Date: Mon, 30 Jul 2007 22:10:43 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: [SPARC32] NULL pointer derefference
In-Reply-To: <Pine.LNX.4.61.0707300301340.32210@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0707300301340.32210@mtfhpc.demon.co.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

On 7/29/07, Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
> Hi All,
>
> Unfortunatly Sparc32 sun4c low level memory management apears to be
> incompatible with commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
> mm: variable length argument support.

I feel like I ought to help out with this since it's my change which
broke things, but I don't have access to a Sparc32 box.  Does anyone
have a remotely rebootable machine I can use?

Ollie
