Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33198 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbETB5D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 21:57:03 -0400
MIME-Version: 1.0
In-Reply-To: <20150520005510.GA23559@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
Date: Tue, 19 May 2015 18:57:02 -0700
Message-ID: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c++std-parallel@accu.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com
Message-ID: <20150520015702.urr1uMRff8JJa2QrssqN-7w-2INOaAjzBuQQAoJeKDo@z>

On Tue, May 19, 2015 at 5:55 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
>         http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf
