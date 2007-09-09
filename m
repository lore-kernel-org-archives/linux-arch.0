Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38549 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757632AbXIIS0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:26:34 -0400
In-Reply-To: <20070909180254.GA20086@uranus.ravnborg.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <214e7ea7cfce67dca284414d82062854@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kbuild: enable possibility to specify xFLAGS on commandline
Date: Sun, 9 Sep 2007 20:26:16 +0200
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <ak@suse.de>, linux arch <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, kbuild devel <kbuild-devel@lists.sourceforge.net>
List-ID: <linux-arch.vger.kernel.org>

> powerpc I dave a toolchain but defconfig seems not to be present.

powerpc uses

	KBUILD_DEFCONFIG := $(shell uname -m)_defconfig

to automagically pick the defconfig you want, but that obviously
doesn't work for cross-builds.

pmac32_defconfig and pseries_defconfig are probably used the most,
you might want to test with one of those next time.


Segher

