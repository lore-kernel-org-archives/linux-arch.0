Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752478AbdIFXLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2017 19:11:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v86NBAPQ027760
        for <linux-arch@vger.kernel.org>; Wed, 6 Sep 2017 19:11:22 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ctpfk09b6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 06 Sep 2017 19:11:22 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 6 Sep 2017 19:11:20 -0400
Date: Wed, 6 Sep 2017 16:11:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: LPC Linux Kernel Memory Workshop next week!
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20170906231117.GA21582@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: j.alglave@ucl.ac.uk, luc.maranget@inria.fr, parri.andrea@gmail.com, stern@rowland.harvard.edu, will.deacon@arm.com, kstewart@linuxfoundation.org, dhaval.giani@gmail.com, rostedt@goodmis.org, josh@joshtriplett.org, longman@redhat.com, dave@stgolabs.net
Message-ID: <20170906231117.FtrbkbLFtgMSMoB3jGj-OtYbz7fZguXi8S_I8_lrykY@z>

Hello!

Linux Plumbers Conference is coming up soon, and with it the Linux Kernel
Memory Model Workshop.  You will get the most out of this workshop if
you install the memory-model tools ahead of time.  Don't get me wrong, we
are of course happy to help people with this installation, but we would
be even more happy to help people use the tools and the memory model!
Plus, if you install ahead of time, you have less need to worry about
the condition of the Internet connection during the event.  ;-)

Here are the installation steps:

Installing the memory model and related tools:
1. Install ocaml v4.01.0 or better: http://caml.inria.fr/download.en.html
   (Or, likely easier, install your distro's version)
   a. But if you choose to build it yourself, do yourself a favor and read
      -all- of Step 5 before starting, or you will miss the "make world.opt"
      shortcut
   b. In addition, recent versions of ocaml require opam (see "herd"
      README from next step)
2. Download and install "herd" tool: http://diy.inria.fr/sources/index.html
3. Download and install memory model itself:
   https://github.com/aparri/memory-model
4. (Optional) Download litmus tests: https://github.com/paulmckrcu/litmus

Steps 1 and 2 are the most time-consuming, and thus the most beneficial
to complete ahead of time.

Hope to see you there!

							Thanx, Paul
