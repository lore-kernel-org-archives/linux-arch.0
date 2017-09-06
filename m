From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: LPC Linux Kernel Memory Workshop next week!
Date: Wed, 6 Sep 2017 16:11:17 -0700
Message-ID: <20170906231117.GA21582@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: j.alglave@ucl.ac.uk, luc.maranget@inria.fr, parri.andrea@gmail.com, stern@rowland.harvard.edu, will.deacon@arm.com, kstewart@linuxfoundation.org, dhaval.giani@gmail.com, rostedt@goodmis.org, josh@joshtriplett.org, longman@redhat.com, dave@stgolabs.net
List-Id: linux-arch.vger.kernel.org

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
