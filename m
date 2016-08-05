Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36622 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcHEMM3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2016 08:12:29 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH 0/5] kbuild changes, thin archives, --gc-sections
Date: Fri,  5 Aug 2016 22:11:58 +1000
Message-ID: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160805121158.lsNXK-kc7MFb_yyuQX4iOh0dEO3ItP3gTBQu_Ebu4kk@z>

Hello,

I have 3 different things in this patchset. All arch specific, but all
involve kbuild changes, so I'd like to discuss them with kbuild
maintainers. The goal has been to improve long standing linking
difficulties with the powerpc kernel.

* First, building kernel using thin archives rather than incremental
  linking. This seems quite clean and is per-arch, so I hope it should
  not be too controversial.

* Second, building kernel using -ffunction-sections -fdata-sections,
  --gc-sections. Yes, I'm spinning the wheel again. It was motivated
  by tiny codesize regression in the first patch, but the results seem
  too good to ignore.

* Third, allowing architecture to run a tool over module after it has
  been linked. Powerpc wants to use it in order to relocate "alternate
  code" instructions that get don't get linked at their runtime
  address. No idea if this is the right approach wrt kbuild, but it
  seems to work.

I have included the powerpc code for the first two as a reference. The
third is much bigger and mostly uninteresting for this cc list, but it
can be found here:

 https://patchwork.ozlabs.org/patch/651006/

Comments appreciated.

Thanks,

