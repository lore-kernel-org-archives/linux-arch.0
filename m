From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: CONFIG_* symbols in UAPI headers?
Date: Tue, 09 Apr 2019 22:54:49 +0200
Message-ID: <023f28b1990577648c33281e1f4588d0abc8aa69.camel@tiscali.nl>
References: <20190408124640.GA607@lst.de>
         <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Paul Bolle schreef op di 09-04-2019 om 21:11 [+0200]:
> Does it still apply?

It does, cleanly. Output is (for v5.1-rc4):

./usr/include/asm-generic/fcntl.h:119: leaks CONFIG_64BIT to userspace where it is not valid
./usr/include/asm-generic/mman-common.h:22: leaks CONFIG_MMAP_ALLOW_UNINITIALIZED to userspace where it is not valid
./usr/include/linux/elfcore.h:62: leaks CONFIG_BINFMT_ELF_FDPIC to userspace where it is not valid
./usr/include/linux/flat.h:17: leaks CONFIG_BINFMT_SHARED_FLAT to userspace where it is not valid
./usr/include/linux/atmdev.h:104: leaks CONFIG_COMPAT to userspace where it is not valid
./usr/include/linux/pktcdvd.h:37: leaks CONFIG_CDROM_PKTCDVD_WCACHE to userspace where it is not valid
./usr/include/linux/raw.h:17: leaks CONFIG_MAX_RAW_DEVS to userspace where it is not valid
./usr/include/linux/hw_breakpoint.h:27: leaks CONFIG_HAVE_MIXED_BREAKPOINTS_REGS to userspace where it is not valid
./usr/include/linux/eventpoll.h:82: leaks CONFIG_PM_SLEEP to userspace where it is not valid
./usr/include/asm/auxvec.h:14: leaks CONFIG_IA32_EMULATION to userspace where it is not valid
./usr/include/asm/mman.h:7: leaks CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS to userspace where it is not valid

Which suggests it might be doable to silence these warnings.


Paul Bolle
