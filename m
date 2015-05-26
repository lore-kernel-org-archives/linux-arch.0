From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 0/3] add new strscpy() API for string copy
Date: Tue, 26 May 2015 15:33:12 -0400
Message-ID: <201505261933.t4QJXCIW015524@farm-0024.internal.tilera.com>
References: <1431911611.13218.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0079.outbound.protection.outlook.com ([157.55.234.79]:23184
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751011AbbEZTdV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 May 2015 15:33:21 -0400
In-Reply-To: <1431911611.13218.1.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On 05/17/2015 09:13 PM, Michael Ellerman wrote:
> On Fri, 2015-05-15 at 11:15 -0400, Chris Metcalf wrote:
>> On 05/14/2015 07:10 PM, Michael Ellerman wrote:
>>> On Thu, 2015-04-30 at 12:01 -0400, Chris Metcalf wrote:
>>>>
>>>> I tested the implementation with a simple user-space harness, so I
>>>> believe it is correct for the corner cases I could think of.  In
>>>> particular I pairwise-tested all the unaligned values of source and
>>>> dest, and tested the restriction on src page-crossing at all
>>>> unaligned offsets approaching the page boundary.
>>> Can you please put that in tools/testing/selftests and merge it as part of the
>>> series? That way I can run the tests and be confident it works on powerpc.
>>
>> Unfortunately, the strscpy patch series only changes the one previous
>> user of the API, which is a tile-architecture-only driver piece, not
>> particularly useful for anyone else for testing.
>>
>> The testing I did pulled strscpy() and word-at-a-time out into a
>> separate, standalone userspace implementation, and tested it there,
>> rather than doing tests through the syscall API like 
>> tools/testing/selftests.
>
> Not everything in selftests has to or does go through the syscall API.
>
> We (powerpc) have tests of our memcpy/memcmp/load_unaligned_zeropad that are
> built as standalone test programs.
>
> Doing that for stuff in lib/string.c does look a bit complicated, because you'd
> need to pull in a bunch of kernel headers.
>
> Do you mind posting your test code somewhere so I can run it, and maybe I can
> work out how to fold it into a selftest.

Seems easiest to just post it to LKML so anyone else who wants to can
take a look at it.  Trying to post a collection of files without
violating the "no MIME parts" rule for LKML made me dust off my
Usenet memories and track down a version of shar to use to bundle up
the test.c harness, the strscpy.c code (excerpted from lib/string.c with
suitable #defines and #includes so it builds in userspace), and a
version of word-at-a-time.h that works for the two environments I
tested it in (x86_64 and tile).
-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com


#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2.1).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# existing files WILL be overwritten
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   2294 -rw-r--r-- test.c
#   3321 -rw-r--r-- strscpy.c
#   2905 -rw-r--r-- word-at-a-time.h
#
echo=echo
if mkdir _sh15429; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= test.c ==============
  $echo 'x -' extracting 'test.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'test.c' &&
/* Compile "gcc -O -o test test.c strscpy.c" and run "./test" */
X
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/mman.h>
X
size_t strscpy_truncate(char *dest, const char *src, size_t count);
size_t strscpy(char *dest, const char *src, size_t count);
X
char dest[1024] __attribute__((aligned(8)));
char src[1024] __attribute__((aligned(8)));
X
#define assert(check) do {                                              \
X  if (!(check)) {                                                       \
X    printf("%s: %d: %d: %s @%zd: %d => %d\n", #check, i, j, s, count, rc, ret); \
X    exit(1);                                                            \
X  } } while (0)
X
void test(int i, int j, char *s, size_t count, int ret)
{
X  int rc;
X
X  if (ret == -1)
X    ret = strlen(s);
X
X  memset(dest, 0, sizeof(dest));
X  memset(src, 0, sizeof(src));
X  strcpy(&src[i], s);
X  rc = strscpy(&dest[j], &src[i], count);
X  assert(rc == ret);
X  if (rc > 0)
X    assert(strcmp(&dest[j], s) == 0);
X  else if (count > 0)
X    assert(dest[j] == '\0');
X
X  memset(dest, 0, sizeof(dest));
X  memset(src, 0, sizeof(src));
X  strcpy(&src[i], s);
X  rc = strscpy_truncate(&dest[j], &src[i], count);
X  assert(rc == ret);
X  if (rc > 0)
X    assert(strcmp(&dest[j], s) == 0);
X  else if (count > 0) {
X    assert(strncmp(&dest[j], s, count-1) == 0);
X    assert(dest[j+count-1] == '\0');
X  }
}
X
int main()
{
X  int i, j;
X
X  for (i = 0; i < 15; ++i) {
X    for (j = 0; j < 15; ++j) {
X      test(i, j, "Hello, world", sizeof(src) - i, -1);
X      test(i, j, "Hello, world", 12, -E2BIG);
X      test(i, j, "foo", 0, -E2BIG);
X      test(i, j, "foo", 1, -E2BIG);
X    }
X  }
X
X  /* Check we never walk across a page boundary past the source. */
X  char *p = mmap(NULL, 2*getpagesize(), PROT_READ|PROT_WRITE,
X                 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
X  mprotect(p+getpagesize(), getpagesize(), PROT_NONE);
X  char *base = p + getpagesize() - 16;
X  strcpy(base, "This is some ra");
X  for (i = 0; i < 15; ++i) {
X    memset(dest, 0, 16);
X    int rc = strscpy_truncate(dest, base + i, sizeof(dest));
X    if (rc != 16 - i - 1 || strcmp(dest, base + i) != 0) {
X      printf("Badness at %d %d\n", i, rc);
X      exit(1);
X    }
X  }
X
X  printf("OK!\n");
X  return 0;
}
SHAR_EOF
  chmod 0644 'test.c' ||
  $echo 'restore of' 'test.c' 'failed'
# ============= strscpy.c ==============
  $echo 'x -' extracting 'strscpy.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'strscpy.c' &&
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include "word-at-a-time.h"
#ifndef __tile__
#define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
#endif
#define PAGE_SIZE getpagesize()
#define EXPORT_SYMBOL(sym)
X
#ifndef __HAVE_ARCH_STRSCPY_TRUNCATE
/**
X * strscpy_truncate - Copy a C-string into a sized buffer
X * @dest: Where to copy the string to
X * @src: Where to copy the string from
X * @count: Size of destination buffer
X *
X * Copy the string, or as much of it as fits, into the dest buffer.
X * The routine returns the number of characters copied (not including
X * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
X * The behavior is undefined if the string buffers overlap.
X *
X * Note that the implementation is robust to the string changing out
X * from underneath it, unlike the current strlcpy() implementation,
X * and it is easier to check overflow than with strlcpy()'s API.
X *
X * strscpy() is preferred over this function unless a truncated string
X * provides some valid semantics in the destination buffer.
X */
ssize_t strscpy_truncate(char *dest, const char *src, size_t count)
{
X	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
X	size_t max = count;
X	long res = 0;
X
X	if (count == 0)
X		return -E2BIG;
X
#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
X	/*
X	 * If src is unaligned, don't cross a page boundary,
X	 * since we don't know if the next page is mapped.
X	 */
X	if ((long)src & (sizeof(long) - 1)) {
X		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
X		if (limit < max)
X			max = limit;
X	}
#else
X	/* If src or dest is unaligned, don't do word-at-a-time. */
X	if (((long) dest | (long) src) & (sizeof(long) - 1))
X		max = 0;
#endif
X
X	while (max >= sizeof(unsigned long)) {
X		unsigned long c, data;
X
X		c = *(unsigned long *)(src+res);
X		*(unsigned long *)(dest+res) = c;
X		if (has_zero(c, &data, &constants)) {
X			data = prep_zero_mask(c, data, &constants);
X			data = create_zero_mask(data);
X			return res + find_zero(data);
X		}
X		res += sizeof(unsigned long);
X		count -= sizeof(unsigned long);
X		max -= sizeof(unsigned long);
X	}
X
X	while (count) {
X		char c;
X
X		c = src[res];
X		dest[res] = c;
X		if (!c)
X			return res;
X		res++;
X		count--;
X	}
X
X	/* Hit buffer length without finding a NUL; force NUL-termination. */
X	if (res)
X		dest[res-1] = '\0';
X
X	return -E2BIG;
}
EXPORT_SYMBOL(strscpy_truncate);
#endif
X
#ifndef __HAVE_ARCH_STRSCPY
/**
X * strscpy - Copy a C-string into a sized buffer, but only if it fits
X * @dest: Where to copy the string to
X * @src: Where to copy the string from
X * @count: Size of destination buffer
X *
X * Copy the string into the dest buffer.  The routine returns the
X * number of characters copied (not including the trailing NUL) or
X * -E2BIG if the destination buffer wasn't big enough.  The behavior
X * is undefined if the string buffers overlap.  The destination buffer
X * is set to the empty string if the buffer is not big enough.
X *
X * Preferred over strlcpy() in all cases, and over strncpy() unless
X * the latter's zero-fill behavior is desired and truncation of the
X * source string is known not to be an issue.
X */
ssize_t strscpy(char *dest, const char *src, size_t count)
{
X	ssize_t res = strscpy_truncate(dest, src, count);
X	if (res < 0 && count != 0)
X		dest[0] = '\0';
X	return res;
}
EXPORT_SYMBOL(strscpy);
#endif
SHAR_EOF
  chmod 0644 'strscpy.c' ||
  $echo 'restore of' 'strscpy.c' 'failed'
# ============= word-at-a-time.h ==============
  $echo 'x -' extracting 'word-at-a-time.h' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'word-at-a-time.h' &&
#ifndef _ASM_WORD_AT_A_TIME_H
#define _ASM_WORD_AT_A_TIME_H
X
#define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
X
#ifndef __tile__
#define IS_UNALIGNED(src, dst)	0
#else
#define IS_UNALIGNED(src, dst)	\
X	(((long) dst | (long) src) & (sizeof(long) - 1))
#endif
X
#ifdef __BIG_ENDIAN__
X
struct word_at_a_time {
X	const unsigned long high_bits, low_bits;
};
X
#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0xfe) + 1, REPEAT_BYTE(0x7f) }
X
/* Bit set in the bytes that have a zero */
static inline long prep_zero_mask(unsigned long val, unsigned long rhs, const struct word_at_a_time *c)
{
X	unsigned long mask = (val & c->low_bits) + c->low_bits;
X	return ~(mask | rhs);
}
X
#define create_zero_mask(mask) (mask)
X
static inline long find_zero(unsigned long mask)
{
X	long byte = 0;
#ifdef _LP64
X	if (mask >> 32)
X		mask >>= 32;
X	else
X		byte = 4;
#endif
X	if (mask >> 16)
X		mask >>= 16;
X	else
X		byte += 2;
X	return (mask >> 8) ? byte : byte + 1;
}
X
static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
{
X	unsigned long rhs = val | c->low_bits;
X	*data = rhs;
X	return (val + c->high_bits) & ~rhs;
}
X
#ifndef zero_bytemask
#define zero_bytemask(mask) (~1ul << __fls(mask))
#endif
X
#else
X
/*
X * The optimal byte mask counting is probably going to be something
X * that is architecture-specific. If you have a reliably fast
X * bit count instruction, that might be better than the multiply
X * and shift, for example.
X */
struct word_at_a_time {
X	const unsigned long one_bits, high_bits;
};
X
#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
X
#ifdef _LP64
X
/*
X * Jan Achrenius on G+: microoptimized version of
X * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
X * that works for the bytemasks without having to
X * mask them first.
X */
static inline long count_masked_bytes(unsigned long mask)
{
X	return mask*0x0001020304050608ul >> 56;
}
X
#else	/* 32-bit case */
X
/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
static inline long count_masked_bytes(long mask)
{
X	/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
X	long a = (0x0ff0001+mask) >> 23;
X	/* Fix the 1 for 00 case */
X	return a & mask;
}
X
#endif
X
/* Return nonzero if it has a zero */
static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
{
X	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
X	*bits = mask;
X	return mask;
}
X
static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
{
X	return bits;
}
X
static inline unsigned long create_zero_mask(unsigned long bits)
{
X	bits = (bits - 1) & ~bits;
X	return bits >> 7;
}
X
/* The mask we created is directly usable as a bytemask */
#define zero_bytemask(mask) (mask)
X
static inline unsigned long find_zero(unsigned long mask)
{
X	return count_masked_bytes(mask);
}
X
#endif /* __BIG_ENDIAN */
X
#endif /* _ASM_WORD_AT_A_TIME_H */
SHAR_EOF
  chmod 0644 'word-at-a-time.h' ||
  $echo 'restore of' 'word-at-a-time.h' 'failed'
rm -fr _sh15429
exit 0
