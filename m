From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3 0/5] Perf tool fixes for ARC + uClibc
Date: Mon, 19 Jan 2015 10:05:08 +0530
Message-ID: <54BC897C.7070309@synopsys.com>
References: <1421156604-30603-1-git-send-email-vgupta@synopsys.com> <20150114120000.GB11443@krava.brq.redhat.com> <20150114135930.GA2463@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20150114135930.GA2463@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, Alexey.Brodkin@synopsys.com
List-Id: linux-arch.vger.kernel.org

Hi Arnaldo,

On Wednesday 14 January 2015 07:29 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 14, 2015 at 01:00:00PM +0100, Jiri Olsa escreveu:
>> > On Tue, Jan 13, 2015 at 07:13:19PM +0530, Vineet Gupta wrote:
>>> > > Hi,
>>> > > 
>>> > > This series based off linux-next of 20150105 allows us to build/use perf
>>> > > for ARC with uClibc based userland.
>>> > > 
>>> > > v3: Changes since v2 [2]
>>> > > * 1/5	: Ack from Jiri
>>> > > * 2/5	: no changes
>>> > > * 3/5	: sys/syscall.h included	  [Jiri]
>>> > > * 4/5	: no changes
>>> > > * 5/5	: -lpthread added to link target  [Jiri]
>>> > > * {1,5} : Changelog updated so scissor lines don't start at column 1
>> > 
>> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> Most are already in my perf/urgent branch.
> 
> - Arnaldo

Are you planning to add {4,5}/5 for next window or did u drop/miss them ?

Thx,
-Vineet
