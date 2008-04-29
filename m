Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36412 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbYD2Skt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Apr 2008 14:40:49 -0400
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-reply-to: Your message of "Tue, 29 Apr 2008 12:46:08 +1000."
             <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 20:40:47 +0200
Message-ID: <20080429184047.47CB7247B4@gemini.denx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com
Message-ID: <20080429184047.jjf_JtgSUXLq9taXeqnoobsB82Ozd16ZJEjAZG3aeeA@z>

In message <18454.35824.527711.355488@cargo.ozlabs.ibm.com> you wrote:
> 
> > Am I missing something here or does this add a branch for every normal
> > syscall?
> 
> It does, but the impact is so small as to be unmeasurable with
> lmbench, even on the null syscall measurement.  The overhead of the
> easily-predicted not-taken branch is completely swamped by the amount
> of time that the sc and rfid instructions take.  I had it under a
> config option at one point but then decided not to bother with that
> when I couldn't measure any difference.

This probably depends a bit on  the  performance  of  the  system  in
question. Did you measure it - for example - on a 50 MHz MPC850 ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.
