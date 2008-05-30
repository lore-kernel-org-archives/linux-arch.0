Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:10499 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761824AbYE3ESz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 00:18:55 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2901817wxd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 21:18:54 -0700 (PDT)
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
References: <1212092282.28403.107.camel@brick> <483F65CA.4050507@rtr.ca>
	 <20080529195225.5665ae9c.akpm@linux-foundation.org>
	 <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 29 May 2008 21:18:52 -0700
Message-ID: <1212121132.28403.182.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Lord <liml@rtr.ca>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
Message-ID: <20080530041852.mNGqk2hJdtwU5E3MWVrXgWkHDeXbFx8g4uR00nWXZ8s@z>

On Fri, 2008-05-30 at 14:10 +1000, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:

> Plus we have a common idiom that get_*() functions increment some sort
> of reference count, and put_*() functions decrease a reference count
> and may free something...

Except for get_unaligned(), put_unaligned()

But point taken.

Harvey

