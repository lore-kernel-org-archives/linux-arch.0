From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 1/5] perf tools: [uclibc] fix statfs.f_type data type
 mismatch build error
Date: Tue, 13 Jan 2015 04:49:42 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307565BCBBD6@IN01WEMBXA.internal.synopsys.com>
References: <1420888254-17504-1-git-send-email-vgupta@synopsys.com>
 <1420888254-17504-2-git-send-email-vgupta@synopsys.com>
 <20150112110522.GC26229@krava.redhat.com> <20150113014757.GG29743@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "namhyung@kernel.org" <namhyung@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, Borislav Petkov <bp@suse.de>, Cody P Schafer <dev@codyps.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 13 January 2015 07:18 AM, Arnaldo Carvalho de Melo wrote:

Em Mon, Jan 12, 2015 at 12:05:22PM +0100, Jiri Olsa escreveu:


> On Sat, Jan 10, 2015 at 04:40:50PM +0530, Vineet Gupta wrote:


> > From: Alexey Brodkin <abrodkin@synopsys.com><mailto:abrodkin@synopsys.com>
> >
> > ARC Linux uses the no legacy syscalls abi and corresponding uClibc headers
> > statfs defines f_type to be U32 which causes perf build breakage
> >
> > http://git.uclibc.org/uClibc/tree/libc/sysdeps/linux/common-generic/bits/statfs.h
> >
> > ----------->8---------------
> >   CC       fs/fs.o
> > fs/fs.c: In function 'fs__valid_mount':
> > fs/fs.c:82:24: error: comparison between signed and unsigned integer
> > expressions [-Werror=sign-compare]
> >   else if (st_fs.f_type != magic)
> >                         ^
> > cc1: all warnings being treated as errors
> > ----------->8---------------
> >
> > Cc: Borislav Petkov <bp@suse.de><mailto:bp@suse.de>
> > Cc: Jiri Olsa <jolsa@kernel.org><mailto:jolsa@kernel.org>
> > Cc: Cody P Schafer <dev@codyps.com><mailto:dev@codyps.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com><mailto:acme@redhat.com>
> > Cc: linux-perf-users@vger.kernel.org<mailto:linux-perf-users@vger.kernel.org>
> > Cc: linux-kernel@vger.kernel.org<mailto:linux-kernel@vger.kernel.org>
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com><mailto:abrodkin@synopsys.com>


>
> Acked-by: Jiri Olsa <jolsa@kernel.org><mailto:jolsa@kernel.org>


Thanks, applied, but please do not start lines in the changelog comment
with ---, that breaks some patch applying scripts. I fixed it up this
time.

Thx. I've udpated the changelogs so scissor lines start at column 3 with leading whitespace, is that OK or do you want me to remove those lines altogether. Also do u want me to drop this patch from v3 of series as I have some fixups for other patches.

Thx,
-Vineet



- Arnaldo
