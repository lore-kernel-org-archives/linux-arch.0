From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
Date: Fri, 13 Jul 2018 11:23:12 +0100
Message-ID: <11103.1531477392@warthog.procyon.org.uk>
References: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com> <cover.1530465325.git.ren_guo@c-sky.com> <27030.1531302693@warthog.procyon.org.uk> <20180712125152.GA5226@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
Content-ID: <11102.1531477392.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: dhowells@redhat.com, Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Sandra Loosemore <sandra@codesourcery.com> wrote:

> I'm not familiar with the Fedora tools, but to build a complete toolchain
> you'll need library support as well and I'm not sure what the submission
> status/plans for that are.

The idea behind the cross-gcc package in Fedora is that it's for kernel builds
and bootloader-type things only.  It builds libgcc, but doesn't use kernel
headers or a C library[*] as this enormously simplifies things.

The reasons being:

 (1) Not all arches can use the same set of C libraries (some can't use glibc
     and some don't have a uClibc port).

 (2) I can only build each individual compiler against a single C library - so
     if you have two or more incompatible environments, you're out of luck -
     I can only use one.

 (3) Building lots more compilers for individual environments would massively
     increase the build size and time.  A full cross-gcc build now takes the
     best part of a day to build.

[*] Yes, there's one exception: it builds the arm compiler against an arm
    cross-glibc - not my idea.

David
