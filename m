Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49072
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750756AbWFBAm6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Jun 2006 20:42:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.sfo1.dsl.speakeasy.net (Postfix) with ESMTP id B9D38AE40CA
	for <linux-arch@vger.kernel.org>; Thu,  1 Jun 2006 17:42:11 -0700 (PDT)
Date: Thu, 01 Jun 2006 17:42:11 -0700 (PDT)
Message-Id: <20060601.174211.59466915.davem@davemloft.net>
Subject: Re: mremap() BUG on virtually indexed caches
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060601.153345.69384736.davem@davemloft.net>
References: <20060601.140433.40742272.davem@davemloft.net>
	<20060601.153345.69384736.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: David Miller <davem@davemloft.net>
Date: Thu, 01 Jun 2006 15:33:45 -0700 (PDT)

> Ignore my test program, it's seriously buggy :)

Ok, this version of the test program below works for me and I verified
my fix as well (after fixing some local variable name clashes in my
move_pte() macro, notably "__pfn" which is also used by pfn_to_page()
which resulted in fun oopses :-)

The biggest pain is that the MREMAP_FIXED stuff is not available in
anything other than current glibc's, and the only way to get at the
extra mremap() argument is to do everything usually obtained from
sys/mman.h by hand :( I tried to get all the platform cases right, but
please double check before you try this test program.

Thanks!

/* mremap() stress tester for D-cache aliasing platforms.
 *
 * Copyright (C) 2006 David S. Miller (davem@davemloft.net)
 *
 * It tries to exercise the case where mremap() with MREMAP_MAYMOVE
 * will actually place the area somewhere else and not just extend
 * or shrink at the existing mapping location.
 *
 * This can cause problems on virtually indexed cache platforms
 * if they do not implement move_pte() with logic to handle a
 * change of virtual color.  If the cache virtual color changes
 * when mremap() moves the mapping around, we can end up accessing
 * stale aliases in the cache on subsequent cpu accesses to the
 * new virtual addresses.
 *
 * This bug was first discovered as file corruption occuring occaisionally
 * in 'dpkg'.  When 'dpkg' is building a 'status' or 'available' file it
 * uses an expanding allocator called 'varbuf' which uses realloc()
 * heavilly to expand it's internal buffer.  In glibc, for very large
 * malloc() buffer sizes, realloc() uses mremap() with MREMAP_MAYMOVE to
 * try and satisfy expansion requests.  Most of the time there is room
 * in the address space, but if we bump up against anoter mmap() region
 * it can move things around.  If this results in different D-cache coloring
 * for the region we can end up reading corrupt data from existing aliases
 * in the D-cache.
 *
 * It was very hard to reproduce, so this test case was written.
 */

#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

/* XXX There is no easy way to get at mremap()'s MREAMP_FIXED functionality
 * XXX with older glibc versions...
 */
extern void *mremap(void *old_address, size_t old_size, size_t new_size,
		    unsigned long flags, ...);
# define MREMAP_MAYMOVE	1
# define MREMAP_FIXED	2

extern void *mmap(void *start, size_t length, int prot, int flags, int fd,
		  off_t offset);

/* Same on all platforms... */
#define PROT_READ	0x1		/* Page can be read.  */
#define PROT_WRITE	0x2		/* Page can be written.  */

#if defined(__alpha__)
#define MAP_FIXED	0x100		/* Interpret addr exactly.  */
#else
#if defined(__parisc__)
#define MAP_FIXED	0x04		/* Interpret addr exactly.  */
#else
#define MAP_FIXED	0x10		/* Interpret addr exactly.  */
#endif
#endif

#if defined(__alpha__) || defined(__parisc__)
#define MAP_ANONYMOUS	0x10		/* Don't use a file.  */
#else
#if defined(__mips__) || defined(__xtensa__)
#define MAP_ANONYMOUS	0x800		/* Don't use a file.  */
#else
#define MAP_ANONYMOUS	0x20		/* Don't use a file.  */
#endif
#endif

#define MAP_PRIVATE	0x02		/* Changes are private.  */

#define MAP_FAILED	((void *) -1)

static int page_size;

static void *unmapped_region;

#define MAX_OFFSET	8

static int init_main_buf(void **main_buf_p, int *main_buf_size_p)
{
	page_size = getpagesize();
	*main_buf_size_p = page_size;

	unmapped_region = mmap(NULL, (MAX_OFFSET + 1) * page_size,
			       PROT_READ,
			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (unmapped_region == (void *) MAP_FAILED) {
		perror("mmap() of unmapped_region");
		return 1;
	}
	fprintf(stdout, "unmapped region at %p\n", unmapped_region);
	fflush(stdout);

	*main_buf_p = mmap(unmapped_region, *main_buf_size_p,
			   PROT_READ | PROT_WRITE,
			   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
			   -1, 0);
	if (*main_buf_p == (void *) MAP_FAILED) {
		perror("Initial 1-page mmap() of main_buf");
		return 1;
	}

	fprintf(stdout, "Initial main_buf at %p\n", *main_buf_p);
	fflush(stdout);

	return 0;
}

static void destroy_main_buf(void *main_buf, int main_buf_size)
{
	munmap(main_buf, main_buf_size);
}

static unsigned int key = 0x00000001;

static void fill_page(void *start)
{
	unsigned int *p = start;
	unsigned int *end = start + page_size;

	while (p < end) {
		volatile unsigned int *xp = (volatile unsigned int *) p;

		(void) *xp;

		*p++ = (unsigned int) (p - (unsigned int *) start) + key;
	}
}

static int remap_page(void **main_buf_p, int *main_buf_size_p, int off)
{
	void *p;

	p = mremap(*main_buf_p,
		   *main_buf_size_p,
		   *main_buf_size_p,
		   MREMAP_FIXED | MREMAP_MAYMOVE,
		   unmapped_region + (off * page_size));
	if (p == (void *) MAP_FAILED) {
		perror("mremap() of main_buf");
		return 1;
	}
	*main_buf_p = p;

	return 0;
}

static void check_page(void *start)
{
	unsigned int *p = start;
	unsigned int *end = start + page_size;

	while (p < end) {
		unsigned int val = *p;
		unsigned int exp_val;

		exp_val = (unsigned int) (p - (unsigned int *) start) + key;

		if (val != exp_val) {
			fprintf(stderr, "Bogus value %08x should be %08x\n",
				val, exp_val);
			exit(99);
		}
		p++;
	}
}

static int do_test(void)
{
	void *main_buf;
	int main_buf_size;
	int err, i;

	err = init_main_buf(&main_buf, &main_buf_size);
	if (err)
		return 1;

	while (1) {
		for (i = 0; i < MAX_OFFSET; i++) {
			fill_page(main_buf);

			remap_page(&main_buf, &main_buf_size, i + 1);

			check_page(main_buf);

			key++;
		}
	}

	destroy_main_buf(main_buf, main_buf_size);

	return 0;
}

int main(int argc, char **argv, char **envp)
{
	page_size = getpagesize();

	return do_test();
}
