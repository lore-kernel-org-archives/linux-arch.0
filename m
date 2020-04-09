From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 1/3] fs: Support setting a minimum fd for "lowest
 available fd" allocation
Date: Wed, 8 Apr 2020 20:17:08 -0700
Message-ID: <20200409031708.GC6149@localhost>
References: <cover.1586321767.git.josh@joshtriplett.org>
 <90bf6fd43343ca862e7f61b0834baf2bdbd0e24c.1586321767.git.josh@joshtriplett.org>
 <20200408120040.mtkqmymfazrv3lqk@yavin.dot.cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200408120040.mtkqmymfazrv3lqk@yavin.dot.cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 08, 2020 at 10:00:40PM +1000, Aleksa Sarai wrote:
> On 2020-04-07, Josh Triplett <josh@joshtriplett.org> wrote:
> > Some applications want to prevent the usual "lowest available fd"
> > allocation from allocating certain file descriptors. For instance, they
> > may want to prevent allocation of a closed fd 0, 1, or 2 other than via
> > dup2/dup3, or reserve some low file descriptors for other purposes.
> > 
> > Add a prctl to increase the minimum fd and return the previous minimum.
> > 
> > System calls that allocate a specific file descriptor, such as
> > dup2/dup3, ignore this minimum.
> > 
> > exec resets the minimum fd, to prevent one program from interfering with
> > another program's expectations about fd allocation.
> 
> Why is it implemented as an "increase the value" interface? It feels
> like this is meant to avoid some kind of security trap (with a library
> reducing the value) but it means that if you want to temporarily raise
> the minimum fd number it's not possible (without re-exec()ing yourself,
> which is hardly a fun thing to do).
> 
> Then again, this might've been discussed before and I missed it...

It was: the previous version was a "get" and "set" interface. That
interface didn't allow for the possibility that something else in the
process had already set a minimum. This new atomic increase interface
(which also serves as a "get" interface if you pass 0) makes it possible
for a userspace library to reserve a range. (You have no guarantee about
previously allocated descriptors in that range, but you know that no
*new* automatically allocated descriptors will appear in that range,
which suffices; userspace can do the rest.)

- Josh Triplett
