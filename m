Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:57828 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaGVBUK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jul 2014 21:20:10 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so3476161iga.16
        for <linux-arch@vger.kernel.org>; Mon, 21 Jul 2014 18:20:09 -0700 (PDT)
Date: Mon, 21 Jul 2014 18:20:07 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
In-Reply-To: <53CDBB01.7040007@imgtec.com>
Message-ID: <alpine.DEB.2.02.1407211819340.9778@chino.kir.corp.google.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com> <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com> <53CDBB01.7040007@imgtec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Message-ID: <20140722012007.miOM_kPyJz-E527BJpW_1l8tYsSttyJMKjWTRadkxB8@z>

On Mon, 21 Jul 2014, Leonid Yegoshin wrote:

> Yes, there is one, at least for MIPS. This stuff can be a common ground for
> both platforms (MIPS and XTENSA)
> 

Needs the mips patch as a followup as justification for the change.
