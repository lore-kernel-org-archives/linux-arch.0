Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from vlsi1.gnat.com ([205.232.38.7]:49566 "EHLO vlsi1.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755347AbbEVKzC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 May 2015 06:55:02 -0400
Date: Fri, 22 May 2015 06:43:32 EDT
Subject: Re: Compilers and RCU readers: Once more unto the breach!
In-Reply-To: <20150522064344.GA17518@gmail.com>
References: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
    <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
    <20150520024148.GD6776@linux.vnet.ibm.com>
    <20150520114745.GC11498@arm.com>
    <20150520121522.GH6776@linux.vnet.ibm.com>
    <20150520154617.GE11498@arm.com>
    <20150520181606.GT6776@linux.vnet.ibm.com>
    <20150521192422.GC19204@arm.com>
    <20150521200212.GW6776@linux.vnet.ibm.com>
    <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
    <20150522064344.GA17518@gmail.com>
Message-ID: <20150522104332.5FBFF33CA8@vlsi1.gnat.com>
From: kenner@vlsi1.ultra.nyu.edu (Richard Kenner)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: akpm@linux-foundation.org, c++std-parallel@accu.org, dhowells@redhat.com, gcc@gcc.gnu.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mark.Batty@cl.cam.ac.uk, michaelw@ca.ibm.com, paulmck@linux.vnet.ibm.com, Peter.Sewell@cl.cam.ac.uk, peterz@infradead.org, Ramana.Radhakrishnan@arm.com, torvalds@linux-foundation.org, will.deacon@arm.com
Message-ID: <20150522104332.NTmkgfMlf-z6hXkqJszDKcSvOoGmtIFM59kdW_M5zbY@z>

> (Assuming it's a goal of this standard to be human parseable to more 
> than a few dozen people on the planet.)

Unfortunately, that's rarely a goal of most standards. ;-)
