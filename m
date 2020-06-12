Return-Path: <SRS0=mQnE=7Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFLFHI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2020 01:07:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBDC08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 11 Jun 2020 22:07:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t7so3593987pgt.3
        for <linux-arch@vger.kernel.org>; Thu, 11 Jun 2020 22:07:07 -0700 (PDT)
Date: Thu, 11 Jun 2020 22:07:05 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <202006112201.3B20AB28DC@keescook>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <202006021052.E52618F@keescook>
 <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
 <20200612044757.GA10703@tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612044757.GA10703@tower>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Cree <mcree@orcon.net.nz>, Matt Turner <mattst88@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-alpha <linux-alpha@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Message-ID: <20200612050705.09wAOvX2_yNZW1X2MadsZ5BOqgVwPb9bnfSGdZrU4ww@z>

On Fri, Jun 12, 2020 at 04:47:57PM +1200, Michael Cree wrote:
> On Thu, Jun 11, 2020 at 09:23:52PM -0700, Matt Turner wrote:
> > Since I noticed earlier that using maxcpus=1 on a 2-CPU system
> > prevented the system from hanging, I tried disabling CONFIG_SMP on my
> > 1-CPU system as well. In doing so, I discovered that the RCU torture
> > module (RCU_TORTURE_TEST) triggers some null pointer dereferences on
> > Alpha when CONFIG_SMP is set, but works successfully when CONFIG_SMP
> > is unset.
> > 
> > That seems likely to be a symptom of the same underlying problem that
> > started this thread, don't you think? If so, I'll focus my attention
> > on that.
> 
> I wonder if that is related to user space segfaults we are now seeing
> on SMP systems but not UP systems while building Alpha debian-ports.
> It's happening in the test-suites of builds of certain software
> (such as autogen and guile) but they always build successfully with
> the test suite passing on a UP system.
> 
> When investigating I seem to recall it was a NULL (or near NULL)
> pointer dereference but couldn't make any sense of how it might
> have got into such an obviously wrong state.

By some miracle, I have avoided any experience with RCU bugs. ;) If
the RCU_TORTURE_TEST Oopses or the segfaults are repeatable and don't
go away with the WARN patch reverted, then perhaps it might be used to
bisect to something closer to the root cause?

Given the similarity to the SMP vs UP stuff and the RCU tests, I'd agree
that does seem like the best path to investigate.

-- 
Kees Cook
