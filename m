Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linux-m32r.org ([211.14.7.36]:41266 "EHLO hikaru.fsij.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXLHHay (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 8 Dec 2007 02:30:54 -0500
Received: from gniibe by hikaru.fsij.org with local (Exim 4.63)
	(envelope-from <gniibe@hikaru.fsij.org>)
	id 1J0tqr-00067s-Lx
	for linux-arch@vger.kernel.org; Sat, 08 Dec 2007 16:11:53 +0900
From: NIIBE Yutaka <gniibe@fsij.org>
Subject: mprotect(2) and I-cache/I-TLB
Message-Id: <E1J0tqr-00067s-Lx@hikaru.fsij.org>
Date: Sat, 08 Dec 2007 16:11:53 +0900
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Investigating cache-alias issue, I have found a small bug for CPU
with I/D separate virtually indexed cache.

When mprotect(2) is called, cache and TLB should be flushed.
Specifically, when PROT_EXEC flag is dropped, I-cache and I-TLB should
be flushed.  Or else, when the virtual address space is reused, old
image will be shown to user space incorrectly.

Attached is a test case to see this bug. It executes forever if kernel
doesn't have this bug or your CPU has no problem.
We see "*** BUG: Executed old page ***", when it has this bug.

My machine is KUROBOX/PRO, which uses arm926 variant (VIVT cache, I/D
separate). I have confirmed that there is this bug for that machine.

I have checked kernel snapshot (2.6.24-rc5-git5), this bug is still
there.

I would like to ask architecture maintainers to try this small program
if CPU has virtual cache and I/D separate.

-- 
/*
 * Test program to see protection change bug
 *
 * Confirmed: linux-2.6.12_lsp.1.10.3 for ARM926EJ (VIVT write back, Harvard)
 *
 * 2007-12-07
 *
 * NIIBE Yutaka <gniibe@fsij.org>
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>

#if defined(MREMAP_FIXED)
#else
#define MREMAP_FIXED 2
#endif

#define PAGE_SIZE  0x1000

__asm__(".section .func,\"ax\",%progbits");
__asm__(".balign 32768");
static int __attribute__((section(".func")))
func0(void)
{
  return 0;
}

__asm__(".balign 4096");
static int __attribute__((section(".func")))
func1(void)
{
  return 1;
}
__asm__(".previous");

static void *
allocate_page(void)
{
  void *addr;

  addr = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_EXEC,
	      MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  if (addr == (void *) -1)
    {
      perror("allocate_page");
      exit(1);
    }

  return addr;
}

static void *
mremap_page(void *oldaddr, void *newaddr)
{
  void *addr;

  addr = (void *)syscall(SYS_mremap, oldaddr, PAGE_SIZE, PAGE_SIZE,
			 MREMAP_MAYMOVE|MREMAP_FIXED, newaddr);
  if (addr != newaddr)
    {
      perror("mremap_page");
      exit(1);
    }

  return addr;
}

int
main(int argc, char *argv[])
{
  int ret;
  int (*f0)(void);
  int (*f1)(void);
  int (*new_f0)(void);
  int i;

  f0 = mremap_page(func0, allocate_page());
  f1 = mremap_page(func1, allocate_page());

 loop:
#if 0
  printf("%08x %08x %08x\n", (unsigned long)f0, (unsigned long)f1, (unsigned long)main);
#endif

  f0();
  /* f0 has been called.  It's now on the I-cache, and I-TLB is valid */

  /* Change the protection */
  /*
   * The bug is here.  Corresponding
   * I-cache and I-TLB entry should be flushed when we drop PROT_EXEC
   */
  if (mprotect(f0, PAGE_SIZE, PROT_NONE) < 0)
    {
      perror("mprotect");
      exit(1);
    }

  new_f0 = mremap_page(f0, allocate_page());

  /* move f1 to the place where f0 were there */
  f1 = mremap_page(f1, f0);

  /*
   * We call f1, but we will see bugus f0 image there,
   * because of the kernel bug
   */
  ret = f1();
  if (ret == 0)		/* It's f0! */
    {
      /* With bogus I-TLB it comes here */
      puts("*** BUG: Executed old page ***"); 
      sleep(1);
    }

  f0 = new_f0;
  if (mprotect(f0, PAGE_SIZE, PROT_READ|PROT_EXEC) < 0)
    {
      perror("mprotect");
      exit(1);
    }

  if (ret == 0)			/* We hit the bug!  */
    {
      printf("%d %d\n", f0(), f1()); /* Try again */
      /* We will see that calling f1 returns 1 correctly, after sleep */ 
      exit (0);
    }

  /* Loop until we see the bug */
  goto loop;
}
