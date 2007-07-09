Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from il.qumranet.com ([82.166.9.18]:60468 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbXGIPYm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jul 2007 11:24:42 -0400
Message-ID: <46924EAC.4040300@qumranet.com>
Date: Mon, 09 Jul 2007 18:05:16 +0300
From: Avi Kivity <avi@qumranet.com>
MIME-Version: 1.0
Subject: Changes to smp_call_function_single() semantics
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Recently I wrote an on_cpu() function, which is like 
smp_call_function_single() except that it works if the target cpu 
happens to be the current cpu.  Andi Kleen requested that I fold this 
into smp_call_function_single(), which I did.  The change is trivial as 
might be expected.

My plan is to push the x86 changes with the kvm updates in the current 
merge window (since kvm depends on this functionality), and submit 
patches to other arches individually to the arch maintainer since I 
can't even compile test them.

Are there any objections to this?

-- 
error compiling committee.c: too many arguments to function

