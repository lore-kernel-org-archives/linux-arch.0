Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:50387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262134AbUDXURZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 24 Apr 2004 16:17:25 -0400
Date: Sat, 24 Apr 2004 13:17:06 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [rft] testing BSD accounting format on different archs
Message-Id: <20040424131706.3d1f2c53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__24_Apr_2004_13_17_06_-0700_Kp.CSCB70uW2dMw/"
To: linux-arch@vger.kernel.org
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Sat__24_Apr_2004_13_17_06_-0700_Kp.CSCB70uW2dMw/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Sat, 24 Apr 2004 13:46:54 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [rft] testing BSD accounting format on different archs


I intend to modify the format of the BSD accounting file in a way that

  a) allows cross-platform compatibility using patched acct tools and
  b) is fully binary compatible with the current format.

To make sure these goals are met on all platforms, I'd like to see the 
output of the attached program on all linux ports *except* x86
(I want to keep my Inbox manageable:).

Thanks a lot,
Tim

--Multipart=_Sat__24_Apr_2004_13_17_06_-0700_Kp.CSCB70uW2dMw/
Content-Type: TEXT/plain;
 name="acct_test.c"
Content-Disposition: attachment;
 filename="acct_test.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/types.h>

typedef __u16   comp_t;
#define ACCT_COMM	16

struct acct_v0
{
	char		ac_flag;		/* Accounting Flags */
/*
 *	No binary format break with 2.0 - but when we hit 32bit uid we'll
 *	have to bite one
 */
	__u16		ac_uid;			/* Accounting Real User ID */
	__u16		ac_gid;			/* Accounting Real Group ID */
	__u16		ac_tty;			/* Accounting Control Terminal */
	__u32		ac_btime;		/* Accounting Process Creation Time */
	comp_t		ac_utime;		/* Accounting User Time */
	comp_t		ac_stime;		/* Accounting System Time */
	comp_t		ac_etime;		/* Accounting Elapsed Time */
	comp_t		ac_mem;			/* Accounting Average Memory Usage */
	comp_t		ac_io;			/* Accounting Chars Transferred */
	comp_t		ac_rw;			/* Accounting Blocks Read or Written */
	comp_t		ac_minflt;		/* Accounting Minor Pagefaults */
	comp_t		ac_majflt;		/* Accounting Major Pagefaults */
	comp_t		ac_swaps;		/* Accounting Number of Swaps */
	__u32		ac_exitcode;		/* Accounting Exitcode */
	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
	char		ac_pad[10];		/* Accounting Padding Bytes */
};



struct acct_v1
{
	char		ac_flag;		/* Flags */
	char		ac_version;		/* Always set to ACCT_VERSION */
	/* for binary compatibility back until 2.0 */
	__u16		ac_uid16;		/* LSB of Real User ID */
	__u16		ac_gid16;		/* LSB of Real Group ID */
	__u16		ac_tty;			/* Control Terminal */
	__u32		ac_btime;		/* Process Creation Time */
	comp_t		ac_utime;		/* User Time */
	comp_t		ac_stime;		/* System Time */
	comp_t		ac_etime;		/* Elapsed Time */
	comp_t		ac_mem;			/* Average Memory Usage */
	comp_t		ac_io;			/* Chars Transferred */
	comp_t		ac_rw;			/* Blocks Read or Written */
	comp_t		ac_minflt;		/* Minor Pagefaults */
	comp_t		ac_majflt;		/* Major Pagefaults */
	comp_t		ac_swaps;		/* Number of Swaps */
/*
 * We still need to identify the platforms that used to have no padding
 * before ac_exitcode
 */
	__u16		ac_ahz;			/* AHZ */
	__u32		ac_exitcode;		/* Exitcode */
	char		ac_comm[ACCT_COMM + 1];	/* Command Name */
	__u8		ac_etime_hi;		/* Elapsed Time MSB */
	__u16		ac_etime_lo;		/* Elapsed Time LSB */
	__u32		ac_uid;			/* Real User ID */
	__u32		ac_gid;			/* Real Group ID */
};


struct acct_v2
{
	char		ac_flag;		/* Flags */
	char		ac_version;		/* Always set to ACCT_VERSION */
	/* for binary compatibility back until 2.0 */
	__u16		ac_uid16;		/* LSB of Real User ID */
	__u16		ac_gid16;		/* LSB of Real Group ID */
	__u16		ac_tty;			/* Control Terminal */
	__u32		ac_btime;		/* Process Creation Time */
	comp_t		ac_utime;		/* User Time */
	comp_t		ac_stime;		/* System Time */
	comp_t		ac_etime;		/* Elapsed Time */
	comp_t		ac_mem;			/* Average Memory Usage */
	comp_t		ac_io;			/* Chars Transferred */
	comp_t		ac_rw;			/* Blocks Read or Written */
	comp_t		ac_minflt;		/* Minor Pagefaults */
	comp_t		ac_majflt;		/* Major Pagefaults */
	comp_t		ac_swaps;		/* Number of Swaps */
/*
 * We still need to identify the platforms that used to have no padding
 * before ac_exitcode
 */
	__u32		ac_exitcode;		/* Exitcode */
	__u16		ac_ahz;			/* AHZ */
	char		ac_comm[ACCT_COMM + 1];	/* Command Name */
	__u8		ac_etime_hi;		/* Elapsed Time MSB */
	__u16		ac_etime_lo;		/* Elapsed Time LSB */
	__u32		ac_uid;			/* Real User ID */
	__u32		ac_gid;			/* Real Group ID */
};

struct acct_v0 ac_v0;
struct acct_v1 ac_v1;
struct acct_v2 ac_v2;

#define of(base,member) (int)((void *)&(base.member)-(void *)&base)
#define offsets2(member) of(ac_v1,member),of(ac_v2,member)
#define offsets3(member) of(ac_v0,member),of(ac_v1,member),of(ac_v2,member)
#define offsets12(member0,member1) of(ac_v0,member0),of(ac_v1,member1),of(ac_v2,member1)

char filename[] = "acct_test_XXXXXX";


int main(void)
{
	int i, fd;
	unsigned char buf[16];

	system("uname -m -p -i -o");

	printf("\n"
               "             v0  v1  v2\n"
	       "ac_flag     %3d %3d %3d\n"
	       "ac_version      %3d %3d\n"
	       "ac_uid16    %3d %3d %3d\n"
               "ac_gid16    %3d %3d %3d\n"
	       "ac_tty      %3d %3d %3d\n"
	       "ac_btime    %3d %3d %3d\n"
	       "ac_utime    %3d %3d %3d\n"
	       "ac_stime    %3d %3d %3d\n"
	       "ac_etime    %3d %3d %3d\n"
	       "ac_mem      %3d %3d %3d\n"
	       "ac_io       %3d %3d %3d\n"
	       "ac_rw       %3d %3d %3d\n"
	       "ac_minflt   %3d %3d %3d\n"
	       "ac_majflt   %3d %3d %3d\n"
	       "ac_swaps    %3d %3d %3d\n"
	       "ac_ahz          %3d %3d\n"
	       "ac_exitcode %3d %3d %3d\n"
	       "ac_comm     %3d %3d %3d\n"
	       "ac_etime_hi     %3d %3d\n"
	       "ac_etime_lo     %3d %3d\n"
	       "ac_uid          %3d %3d\n"
	       "ac_gid          %3d %3d\n"
	       "sizeof(struct acct)\n"
	       "            %3d %3d %3d\n\n",
	       offsets3(ac_flag),
	       offsets2(ac_version),
	       offsets12(ac_uid,ac_uid16),
	       offsets12(ac_gid,ac_gid16),
	       offsets3(ac_tty),
	       offsets3(ac_btime),
	       offsets3(ac_utime),
	       offsets3(ac_stime),
	       offsets3(ac_etime),
	       offsets3(ac_mem),
	       offsets3(ac_io),
	       offsets3(ac_rw),
	       offsets3(ac_minflt),
	       offsets3(ac_majflt),
	       offsets3(ac_swaps),
	       offsets2(ac_ahz),
	       offsets3(ac_exitcode),
	       offsets3(ac_comm),
	       offsets2(ac_etime_hi),
	       offsets2(ac_etime_lo),
	       offsets2(ac_uid),
	       offsets2(ac_gid),
	       (int)sizeof(ac_v0), (int)sizeof(ac_v1), (int)sizeof(ac_v2)
	      );

	ac_v0.ac_flag =     0x01;
	ac_v0.ac_uid =      0x0304;
	ac_v0.ac_gid =      0x0506;
	ac_v0.ac_tty =      0x0708;
	ac_v0.ac_btime =    0x090a0b0c;
	ac_v0.ac_utime =    0x0d0e;
	ac_v0.ac_stime =    0x0f10;
	ac_v0.ac_etime =    0x1112;
	ac_v0.ac_mem =      0x1314;
	ac_v0.ac_io =       0x1516;
	ac_v0.ac_rw =       0x1718;
	ac_v0.ac_minflt =   0x191a;
	ac_v0.ac_majflt =   0x1b1c;
	ac_v0.ac_swaps =    0x1d1e;
	ac_v0.ac_exitcode = 0x21222324;
	for (i=0; i<17; i++)
		ac_v0.ac_comm[i] = 0x25+i;
	for (i=0; i<10; i++)
		ac_v0.ac_pad[i] = 0xf0+i;

	ac_v1.ac_flag =     ac_v2.ac_flag =     0x01;
	ac_v1.ac_version =  ac_v2.ac_version =  0x02;
	ac_v1.ac_uid16 =    ac_v2.ac_uid16 =    0x0304;
	ac_v1.ac_gid16 =    ac_v2.ac_gid16 =    0x0506;
	ac_v1.ac_tty =      ac_v2.ac_tty =      0x0708;
	ac_v1.ac_btime =    ac_v2.ac_btime =    0x090a0b0c;
	ac_v1.ac_utime =    ac_v2.ac_utime =    0x0d0e;
	ac_v1.ac_stime =    ac_v2.ac_stime =    0x0f10;
	ac_v1.ac_etime =    ac_v2.ac_etime =    0x1112;
	ac_v1.ac_mem =      ac_v2.ac_mem =      0x1314;
	ac_v1.ac_io =       ac_v2.ac_io =       0x1516;
	ac_v1.ac_rw =       ac_v2.ac_rw =       0x1718;
	ac_v1.ac_minflt =   ac_v2.ac_minflt =   0x191a;
	ac_v1.ac_majflt =   ac_v2.ac_majflt =   0x1b1c;
	ac_v1.ac_swaps =    ac_v2.ac_swaps =    0x1d1e;
	ac_v1.ac_ahz =      ac_v2.ac_ahz =      0x1f20;
	ac_v1.ac_exitcode = ac_v2.ac_exitcode = 0x21222324;
	for (i=0; i<17; i++)
		ac_v1.ac_comm[i] = ac_v2.ac_comm[i] = 0x25+i;
	ac_v1.ac_etime_hi = ac_v2.ac_etime_hi = 0x36;
	ac_v1.ac_etime_lo = ac_v2.ac_etime_lo = 0x3738;
	ac_v1.ac_uid =      ac_v2.ac_uid =      0x393a3b3c;
	ac_v1.ac_gid =      ac_v2.ac_gid =      0x3d3e3f40;


	fd = mkstemp(filename);
	if (write(fd, &ac_v0, 64) != 64) {
		perror("write ac_v0");
		return 1;
	}
	if (write(fd, &ac_v1, 64) != 64) {
		perror("write ac_v1");
		return 1;
	}
	if (write(fd, &ac_v2, 64) < 64) {
		perror("write ac_v2");
		return 1;
	}
	
	if (lseek(fd, 0, SEEK_SET)!=0) {
		perror("seek");
		return 1;
	}

	for (i=0; i<12; i++) {
		if (read(fd, buf, 16) != 16) {
			perror("read");
			return 1;
		}
		printf("    %02x %02x %02x %02x  %02x %02x %02x %02x"
		       "  %02x %02x %02x %02x  %02x %02x %02x %02x\n",
		       buf[0x00], buf[0x01], buf[0x02], buf[0x03],
		       buf[0x04], buf[0x05], buf[0x06], buf[0x07],
		       buf[0x08], buf[0x09], buf[0x0a], buf[0x0b],
		       buf[0x0c], buf[0x0d], buf[0x0e], buf[0x0f]
		      );
		if ((i&3) == 3)
			printf("\n");
	}

	close(fd);

	return 0;
}

--Multipart=_Sat__24_Apr_2004_13_17_06_-0700_Kp.CSCB70uW2dMw/--
