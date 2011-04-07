From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCHES] Generalize PCI <-> OF node matching
Date: Thu,  7 Apr 2011 13:26:31 +1000
Message-ID: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linuxtronix.de, bigeasy@linuxtronix.de
List-Id: linux-arch.vger.kernel.org

This series generalize the PCI <-> OF node matching, moves it to the
PCI core and make our archs use it. I also rip out while at it a whole
bunch of useless stuff from microblaze PCI code which was copied from
ppc32 and is essentially useless there (old workarounds for PowerMac
and ancient X servers).

Compile tested on x86_64, microblaze, sparc64 and powerpc.

How do you guys want to proceed with this series ? It will quickly
become a pre-req for other things on powerpc, so I can carry it in
powerpc in a separate branch that I also pull into powerpc-next or
we can have it somewhere on tip...
