From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH 0/5] kbuild changes, thin archives, --gc-sections
Date: Fri,  5 Aug 2016 22:11:58 +1000
Message-ID: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

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

